#!/bin/bash
NAME="hello_django"                                 # Name of the application
USER="hello"                                        # the user to run as
GROUP="webapps"                                     # the group to run as
REPO="https://github.com/johnrlive/django-server"   # Git repository
DOMAIN="hello.addlocal.com"                         # Domain


echo '====== SETUP Gunicorn'
echo 'Now that you have gunicorn, you can test whether it can serve your Django application by running the following command:'
echo '(hello_django)hello@django:~$ gunicorn hello.wsgi:application --bind example.com:8001'
sleep 1
# gunicorn $USER.wsgi:application --bind $DOMAIN:8001

# You should now be able to access the Gunicorn server from http://example.com:8001 . I intentionally changed port 8000 to 8001 to force your browser to establish a new connection.'
# echo 'Gunicorn is installed and ready to serve your app. Let’s set some configuration options to make it more useful. I like to set a number of parameters, so let’s put them all into a small BASH script, which I save as bin/gunicorn_start'

# echo 'Let’s set some configuration options to make it more useful.'
# sleep 1
echo 'Set the executable bit on the gunicorn_start script:'
sleep 1
sudo chmod u+x bin/gunicorn_start
sudo su - $USER

echo 'type this: bin/gunicorn_start'
sleep 1 
bin/gunicorn_start
echo 'should see: Starting hello_app as hello'
sleep 1
#
#
#
##############################################################################################
#
#

# echo '==== setup supervisor'
# echo 'When Supervisor is installed you can give it programs to start and watch by creating configuration files in the /etc/supervisor/conf.d directory. For our hello application we’ll create a file named /etc/supervisor/conf.d/hello.conf with this content:'
# sleep 1
# cp supervisor.conf.sh /etc/supervisor/conf.d/$NAME.conf
# 
# echo 'Create the file to store your application’s log messages:'
# sleep 1
# mkdir -p /$GROUP/$NAME/logs/
# sudo touch /$GROUP/$NAME/logs/gunicorn_supervisor.log 
# 
# echo 'After you save the configuration file for your program you can ask supervisor to reread configuration files and update (which will start your the newly registered app).'
# sleep 1
# sudo supervisorctl reread
# sudo supervisorctl update
# clear
# sudo supervisorctl status $USER 
# sudo supervisorctl stop $USER 
# sudo supervisorctl start $USER 
# sudo supervisorctl restart $USER 
# sleep 1
# 

# echo '[###### Install Nginx ######]'
# sleep 1
# sudo aptitude -y install nginx
# sudo service nginx start
# sudo cp nginx.sh /etc/nginx/sites-available/$NAME
# sudo ln -s /etc/nginx/sites-available/$NAME /etc/nginx/sites-enabled/$NAME
# sudo service nginx restart


