#!/bin/bash

# Set your desired container name and Apache port
CONTAINER_NAME=my_apache_container
APACHE_PORT=80

# Pull the RHEL Docker image from Docker Hub (you need to have Docker installed)
docker pull registry.access.redhat.com/rhel7

# Create and start a new Docker container using the RHEL image
docker run -d -p $APACHE_PORT:80 --name $CONTAINER_NAME registry.access.redhat.com/rhel7

# Install the Apache web server inside the container using 'yum'
docker exec $CONTAINER_NAME yum -y install httpd

# Start the Apache service
docker exec $CONTAINER_NAME systemctl start httpd

# Enable Apache service to start on boot
docker exec $CONTAINER_NAME systemctl enable httpd

# Print information about the Apache server
echo "Apache web server installed and running inside the Docker container:"
echo "Apache Port: $APACHE_PORT"
echo "Container Name: $CONTAINER_NAME"
echo "You can now access the Apache server by visiting http://localhost:$APACHE_PORT/"

# Additional Configuration (optional):
# If you want to make your web files accessible inside the container, you can mount a directory from the host to the container using the '-v' option in 'docker run':
# docker run -d -p $APACHE_PORT:80 -v /path/to/your/web/files:/var/www/html --name $CONTAINER_NAME registry.access.redhat.com/rhel7
# Make sure the web files are present in the specified host directory (/path/to/your/web/files).

# If you want to use a custom Apache configuration file, you can mount it in the container as well:
# docker run -d -p $APACHE_PORT:80 -v /path/to/your/apache/config:/etc/httpd/conf/httpd.conf --name $CONTAINER_NAME registry.access.redhat.com/rhel7
# Again, make sure the custom Apache configuration file is present in the specified host directory (/path/to/your/apache/config).

# If you want to use a domain name or IP address to access the Apache server instead of localhost, make sure to bind the Apache server to the correct address inside the container's configuration.

# Note: For production setups, consider securing the web server and using HTTPS.
