#!/bin/bash

# Install Docker (you may need to run this script with sudo)
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

# Start the Docker daemon
sudo systemctl start docker

# Launch RHEL container and install required packages
sudo docker run -it --name my_rhel_container rhel /bin/bash << EOF

# Update RHEL and install necessary packages
yum update -y
yum install -y python3 python3-pip

# Install required Python packages
pip3 install numpy scikit-learn pandas matplotlib

# Exit the container
exit

EOF

# Start the container in detached mode
sudo docker start my_rhel_container

# Get into the container to use Python and the installed packages
sudo docker exec -it my_rhel_container /bin/bash
