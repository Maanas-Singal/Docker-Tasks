#!/bin/bash

# Check if Docker is installed on the host
if ! command -v docker &> /dev/null; then
  echo "Docker is not installed on the host. Please install Docker and try again."
  exit 1
fi

# Build the inner Docker container
cat << 'EOF' > Dockerfile_inner
FROM alpine:latest
RUN apk add --update docker
EOF

docker build -t inner_docker -f Dockerfile_inner .

# Build the outer Docker container
cat << 'EOF' > Dockerfile_outer
FROM alpine:latest

# Install Docker inside the container
RUN apk add --update docker

# Copy the Docker CLI binary from the host
RUN cp /usr/bin/docker /usr/bin/docker-host

# Copy the inner Docker binary and configuration from the inner container
COPY --from=inner_docker /usr/bin/docker /usr/bin/docker-inner
COPY --from=inner_docker /usr/lib/docker /usr/lib/docker

# Add entrypoint script to run the inner Docker container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
EOF

# Create the entrypoint script for the outer container
cat << 'EOF' > entrypoint.sh
#!/bin/bash

# Start the Docker daemon inside the outer container
dockerd &

# Wait for the Docker daemon to start
while ! docker info &>/dev/null; do
    echo "Waiting for Docker daemon to start..."
    sleep 1
done

# Run the inner Docker container inside the outer container
docker-inner run -it --rm alpine:latest echo "Hello from the inner container!"

# Stop the Docker daemon before exiting the outer container
docker stop \$(docker ps -q)

EOF
chmod +x entrypoint.sh

# Build the outer Docker container
docker build -t outer_docker -f Dockerfile_outer .

# Run the outer Docker container
docker run -it --rm --privileged outer_docker

# Clean up temporary files
rm Dockerfile_inner Dockerfile_outer entrypoint.sh
