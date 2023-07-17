#!/bin/bash

# Set your desired SSH port and container name
SSH_PORT=2222
CONTAINER_NAME=my_ssh_container

# Pull the RHEL Docker image from Docker Hub (you need to have Docker installed)
docker pull registry.access.redhat.com/rhel7

# Create and start a new Docker container using the RHEL image
docker run -d -p $SSH_PORT:22 --name $CONTAINER_NAME registry.access.redhat.com/rhel7

# Install the SSH server inside the container using 'yum'
docker exec $CONTAINER_NAME yum -y install openssh-server

# Start the SSH service
docker exec $CONTAINER_NAME systemctl start sshd

# Enable SSH service to start on boot
docker exec $CONTAINER_NAME systemctl enable sshd

# Generate SSH keys (optional, if you want to access the container with SSH keys)
docker exec $CONTAINER_NAME ssh-keygen -A

# Print information about the SSH connection
echo "SSH server installed and running inside the Docker container:"
echo "SSH Port: $SSH_PORT"
echo "Container Name: $CONTAINER_NAME"
echo "You can now access the container using the following command:"
echo "ssh root@localhost -p $SSH_PORT"

# Additional configuration (optional):
# If you want to set a root password for the container, you can use the 'passwd' command inside the container:
# docker exec -it $CONTAINER_NAME passwd
# Then, enter and confirm the password for the root user.

# If you want to create a non-root user, you can use the 'useradd' command inside the container:
# docker exec -it $CONTAINER_NAME useradd myuser
# Then, set the password for the new user:
# docker exec -it $CONTAINER_NAME passwd myuser
# You may also want to add the new user to the 'sudoers' group if needed:
# docker exec -it $CONTAINER_NAME usermod -aG wheel myuser
