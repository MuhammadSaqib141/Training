#!/bin/bash

# Update the package list and install Nginx
sudo apt-get update
sudo apt-get install -y nginx

# Create the /health endpoint
echo "Server is healthy" | sudo tee /var/www/html/health

# Create a dynamic index file for the root endpoint that shows the system's hostname
echo "System Name: $(hostname)" | sudo tee /var/www/html/index.html

# Update Nginx configuration to serve the root and health endpoints
sudo bash -c 'cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 8080 default_server;
    listen [::]:8080 default_server;

    server_name _;

    location / {
        root /var/www/html;
        index index.html index.htm;
    }

    location /health {
        default_type text/plain;
        return 200 "Healthy";
    }
}
EOF'

# Test Nginx configuration for errors
if sudo nginx -t; then
    # Restart Nginx to apply the changes
    sudo systemctl restart nginx
    echo "Nginx has been configured and restarted successfully."
else
    echo "Nginx configuration test failed."
    exit 1
fi
