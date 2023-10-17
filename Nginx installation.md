# Installation of Nginx Server, Writing Configuration Files, and Encrypting SSL Certificates

Nginx is a popular web server known for its performance and versatility. Securing it with SSL certificates is essential for serving websites over HTTPS. Below, we'll guide you through the process of installing Nginx, writing Nginx configuration files, and obtaining SSL certificates for secure web hosting. For more information on Nginx, please refer to the official documentation <a href="https://nginx.org/en/docs/beginners_guide.html" target="_blank">Nginx Beginners Guide.</a>

## Prerequisities:
  - Operating System: Ubuntu 22.04
  - Root access or a user with sudo privileges
  - A registered domain with DNS control (e.g., on AWS Route 53 or another domain registrar)
  - Docker installed on the Ubuntu server; Install docker if you want to host website that is in docker container.


## Installing Nginx on Your OS Machine
Nginx is a versatile and high-performance web server that's widely used to serve websites, reverse proxy, and handle various web-related tasks. Installing Nginx on your local operating system (OS) allows you to set up a web development environment or experiment with web server configurations. Here's a brief overview and the steps to download and install Nginx on your OS.

### Nginx Installation Steps:
**Update pakages list**: Before installing new software, it's always a good practice to update your system's package lists. Open your terminal and run the following command:
<blockquote style="background-color: #111111; color: #e0a82f; border-left: 10px solid #000000; padding: 0.5em 1em;">
sudo apt update
</blockquote>
<br>

**Install Nginx**: After updating the package lists, you can install Nginx using your system's package manager. Open your terminal and run the following command:
<blockquote style="background-color: #111111; color: #e0a82f; border-left: 10px solid #000000; padding: 0.5em 1em;">
sudo apt install nginx
</blockquote>
<br>

**Start Nginx**: Once Nginx is installed, you can start the Nginx service with the following command:
<blockquote style="background-color: #111111; color: #e0a82f; border-left: 10px solid #000000; padding: 0.5em 1em;">
sudo systemctl start nginx
</blockquote>
<br>

**Enable Nginx to Start on Boot**: To ensure that Nginx starts automatically when your OS boots, use the following command:
<blockquote style="background-color: #111111; color: #e0a82f; border-left: 10px solid #000000; padding: 0.5em 1em;">
sudo systemctl enable nginx
</blockquote>
<br>

## Writing Nginx Configuration Files:
Writing Nginx configuration files is a crucial step in customizing the behavior of your web server. Nginx configuration files, typically stored in the /etc/nginx/ directory, allow you to define server blocks, configure virtual hosts, set up proxying, and much more. Here's an overview and some basic steps to write Nginx configuration files:

### Steps:
**Choose a File Name**: Create a new configuration file for your website or application. Conventionally, these files are placed in the /etc/nginx/sites-available/ directory and have a .conf extension. You can use a plain text editor or a terminal-based text editor like nano or vim.
<blockquote style="background-color: #111111; color: #e0a82f; border-left: 10px solid #000000; padding: 0.5em 1em;">
sudo nano /etc/nginx/sites-available/example.conf
</blockquote>
<br>

**Define a Server Block**: In the configuration file, define a server block for your website or application. Customize settings such as server_name, listen, root, and location directives according to your requirements.
<blockquote style="background-color: #111111; color: #e0a82f; border-left: 10px solid #000000; padding: 0.5em 1em;">
server {

    listen 80;
    server_name example.com;

    location / {
        root /var/www/html;
        index index.html;
    }
}
</blockquote>
<br>
If the web-application would be running in docker container then the configuration file would be:
<blockquote style="background-color: #111111; color: #e0a82f; border-left: 10px solid #000000; padding: 0.5em 1em;">
server {

    listen 80;
    server_name example.com;

    location / {
       proxy_pass http://ip-address:port;
    }
}
</blockquote>
<br>

**Enable the Configuration File**: After creating the configuration file, you need to enable it by creating a symbolic link in the /etc/nginx/sites-enabled/ directory.
<blockquote style="background-color: #111111; color: #e0a82f; border-left: 10px solid #000000; padding: 0.5em 1em;">
sudo ln -s /etc/nginx/sites-available/example.conf /etc/nginx/sites-enabled/
</blockquote>
<br>

**Test the Configuration**: Before applying the new configuration, it's a good practice to test for syntax errors.
<blockquote style="background-color: #111111; color: #e0a82f; border-left: 10px solid #000000; padding: 0.5em 1em;">
sudo nginx -t
</blockquote>
<br>

**Restart Nginx**: Apply the new configuration by restarting Nginx.
<blockquote style="background-color: #111111; color: #e0a82f; border-left: 10px solid #000000; padding: 0.5em 1em;">
sudo systemctl restarting nginx
</blockquote>

## Encrypting SSL Certificate:
Securing your website with an SSL certificate is an essential step to protect sensitive data, build trust with your users, and improve search engine rankings. SSL (Secure Sockets Layer) certificates enable secure, encrypted connections between web servers and web browsers, ensuring the confidentiality and integrity of data during transmission.

### Steps to install SSL Certificate
**Install Certbot**: Install Certbot and the Nginx plugin for Certbot on your host machine. Certbot automates the process of obtaining and renewing SSL certificates.
<blockquote style="background-color: #111111; color: #e0a82f; border-left: 10px solid #000000; padding: 0.5em 1em;">
sudo apt update<br>
sudo apt install certbot python3-certbot-nginx
</blockquote>
<br>

**Obtain an SSL Certificate**: Use Certbot to request an SSL certificate for your domain. Ensure that the Nginx container is running and configured to handle requests for your domain.
<blockquote style="background-color: #111111; color: #e0a82f; border-left: 10px solid #000000; padding: 0.5em 1em;">
sudo certbot --nginx
</blockquote>
<br>
(Remember to give certificate to each configuration files seperately, else it will give error later on)