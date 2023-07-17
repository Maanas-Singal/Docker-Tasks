#!/bin/bash

# Step 1: Install Docker (Assuming Docker is not installed)
echo "Installing Docker..."
sudo apt-get update
sudo apt-get install -y docker.io

# Step 2: Create a Dockerfile
echo "Creating Dockerfile..."
cat << EOF > Dockerfile
FROM ubuntu:latest

RUN apt-get update && apt-get install -y espeak

CMD ["espeak", "Hello World"]
EOF

# Step 3: Build the Docker Image
echo "Building Docker image..."
sudo docker build -t ubuntu_espeak .

# Step 4: Run the Docker Container
echo "Running Docker container to say 'Hello World'..."
sudo docker run --rm ubuntu_espeak

# Step 5: Clean up (Optional)
echo "Cleaning up..."
rm Dockerfile

echo "Done!"
