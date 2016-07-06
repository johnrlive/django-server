set $APP_NAME firstsite;
set $DOMAIN www.firstsite.com;

server {
    listen 80;
    server_name $DOMAIN;

    location = /favicon.ico { access_log off; log_not_found on; }

    error_log /var/log/$APP_NAME.com_error.log;
    access_log /var/log/$APP_NAME.com_access.log;

    # Maximum file upload size.
    client_max_body_size 64M;

    # Enable content compression for text types.
    gzip on;
    gzip_types text/plain text/css application/x-javascript image/svg+xml;
    gzip_comp_level 1;
    gzip_disable msie6;
    gzip_http_version 1.0;
    gzip_proxied any;
    gzip_vary on;

    location /static/ {
        access_log off;
        expires 3600;
        alias /var/www/$APP_NAME/static/;
    }

    # Set a longer expiry for CACHE/, because the filenames are unique.
    location /static/CACHE/ {
        access_log off;
        expires 864000;
        alias /var/www/$APP_NAME/static/CACHE/;
    }

    # Only server /media/images by default, not e.g. original_images/.
    location /media/images/ {
        expires 864000;
        alias /var/www/$APP_NAME/media/images/;
    }

    location / {
        include         uwsgi_params;
        uwsgi_pass      unix:/run/uwsgi/$APP_NAME.sock;
    }
}
