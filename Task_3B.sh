#!/bin/bash

# Check if Docker is installed
if ! command -v docker &>/dev/null; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if X11 server is installed
if ! command -v xhost &>/dev/null; then
    echo "X11 server is not installed. Please install it first."
    exit 1
fi

# Allow connections to the X server from the Docker container
xhost +local:

# Build the Docker image with X11 support
docker build -t gui_os_image - <<EOF
FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    x11-apps \
    xterm \
    # Install other GUI dependencies here if needed
    && rm -rf /var/lib/apt/lists/*

# Replace 'gui_os_command' with the command to start your GUI OS
CMD ["gui_os_command"]
EOF

# Run the Docker container with X11 forwarding and other necessary options
docker run -it --rm \
    --name gui_os_container \
    --env="DISPLAY" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    gui_os_image

# Reset X11 server permissions after the container exits
xhost -local:
