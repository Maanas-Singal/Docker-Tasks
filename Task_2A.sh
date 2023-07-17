#!/bin/bash

# Check if Docker is installed
if ! [ -x "$(command -v docker)" ]; then
  echo "Docker is not installed. Please install Docker first."
  exit 1
fi

# Check if the X11 socket is accessible
if [ ! -S /tmp/.X11-unix/X0 ]; then
  echo "X11 socket is not accessible. Make sure X11 is running and try again."
  exit 1
fi

# Run the Firefox Docker container
docker run -it --rm \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  --name firefox-container \
  jess/firefox
