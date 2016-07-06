#!/bin/bash

sudo systemctl restart uwsgi
echo '=== uswgi restarted ==='
sleep 1

sudo systemctl restart nginx
echo '=== nginx restarted ==='
sleep 1
