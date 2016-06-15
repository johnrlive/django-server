server {
    listen 80;
    server_name firstsite.com www.firstsite.com;

    location = /favicon.ico { access_log off; log_not_found off; }
    location /static/ {
        root /home/ubuntu/firstsite;
    }

    location / {
        include         uwsgi_params;
        uwsgi_pass      unix:/run/uwsgi/firstsite.sock;
    }
}
