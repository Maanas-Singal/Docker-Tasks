#!/bin/bash

# Update package lists
apt-get update

# Install dependencies
apt-get install -y guvcview

# Configure Guvcview (optional)
# Example: Set the default resolution to 1280x720
echo 'VIDEO_DEVICE="/dev/video0"' >> /etc/default/guvcview
echo 'VIDEO_SIZE="1280x720"' >> /etc/default/guvcview

# Clean up package lists
apt-get clean
rm -rf /var/lib/apt/lists/*

# Start Guvcview (optional)
# Example: Run Guvcview in the background
guvcview --no_display --window_title "Guvcview" &

# Keep the container running
tail -f /dev/null
