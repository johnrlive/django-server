#! /bin/bash/
# APP_NAME="myproject"
# GUNICORN_NAME="myproject.sock"
# USER="ubuntu"
# DOMAIN="example.com"

server {
    listen 80;
    server_name example.com_or_IP;

    location = /favicon.ico { access_log off; log_not_found off; }
    location /static/ {
        root /home/ubuntu/myproject;
    }

    location / {
        include proxy_params;
        proxy_pass http://unix:/home/ubuntu/myproject/myproject.sock;
    }
}
