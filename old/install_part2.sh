#!/bin/bash
NAME="hello_django"                                 # Name of the application
USER="hello"                                        # the user to run as
GROUP="webapps"                                     # the group to run as
REPO="https://github.com/johnrlive/django-server"   # Git repository

echo '#########################################'
echo '#        Activate Virtualenv           # '
echo '#########################################'
sleep 1

# cd /$GROUP/$NAME/
# virtualenv . 
# source bin/activate
# sleep 1

echo '#########################################'
echo '#    Installs django within virtualenv  #'
echo '#########################################'
sleep 1
pip install django

# echo 'your environment with django should be ready to use. go ahead and create an empty django project.'
# sleep 1
# django-admin.py startproject $NAME 
# uncomment this to test django is created
# cd $NAME 
# python manage.py runserver


echo '#########################################'
echo '#            Pillow installed           #'
echo '#########################################'
sleep 1
pip install pillow


echo '#########################################'
echo '#  psycopg2 database adapter installed  #'
echo '#########################################'
sleep 1
pip install psycopg2


echo '#########################################'
echo '#        [START Gunicorn INSTALL]       #'
echo '#########################################'
sleep 1
pip install gunicorn 
#sudo cp /home/admin/django-server/gunicorn_start.sh /$GROUP/$NAME/bin/gunicorn_start


echo '#########################################'
echo '#        Setproctitle installed         #'
echo '#########################################'
sleep 1
pip install setproctitle
#sudo cp /home/admin/django-server/supervisor.conf.sh /etc/supervisor/conf.d/$NAME.conf


echo 'hello@django:~$' 
mkdir -p /$GROUP/$NAME/logs/
echo 'hello@django:~$' 
touch /$GROUP/$NAME/logs/gunicorn_supervisor.log 


# echo '====== run: bash install_part3.sh'
# sleep 1
