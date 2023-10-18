#!/bin/bash

# Check if nginx is installed and running
if ! systemctl is-active --quiet nginx; then
    echo "Nginx is not installed or not running. Installing nginx..."
    sudo apt update
    sudo apt install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
    echo "Nginx is now installed and running."
else
    echo "Nginx is already installed and running."
fi

# Check if certbot and required plugins are installed
if ! command -v certbot &>/dev/null; then
    echo "Certbot not found. Installing Certbot and required plugins..."
    sudo apt update
    sudo apt install -y certbot python3-certbot-nginx
    echo "Certbot and required plugins are now installed."
else
    echo "Certbot and required plugins are already installed."
fi

# Prompt the user for the domain name
read -p "Please enter the domain name you want to use (e.g., www.abc.com): " domain_name

# Prompt the user for the IP address and port
read -p "Enter the IP address and port where you want to forward requests (e.g., 192.168.32.5:3000): " ip_address

# Create an Nginx configuration file for the domain
config_file="/etc/nginx/sites-available/${domain_name}.conf"
echo "Creating Nginx configuration file at $config_file..."

# Write the Nginx configuration to the file
cat > "$config_file" <<EOF
server {
    listen 80;
    server_name $domain_name;

    location / {
        proxy_pass http://$ip_address;
    }
}
EOF

echo "Nginx configuration file created at $config_file."

# Create a symbolic link to enable the site
sudo ln -s "$config_file" "/etc/nginx/sites-enabled/"

echo "Nginx site enabled."

# Restart Nginx to apply the changes
sudo systemctl restart nginx

echo "Nginx restarted."

# Run Certbot to obtain an SSL certificate
sudo certbot --nginx

echo "Certbot has been run to obtain an SSL certificate."
