#!/bin/bash

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker before running this script."
    exit 1
fi

# Create a Dockerfile
cat <<EOF > Dockerfile
FROM ubuntu:latest

# Update the package lists
RUN apt-get update

# Install Firefox
RUN apt-get install -y firefox

# Set the display environment variable
ENV DISPLAY=:0

# Run Firefox
CMD ["firefox"]
EOF

# Build the Docker image
docker build -t my-firefox .

# Run the Docker container with Firefox
docker run -it --rm \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --name firefox-container \
    my-firefox
