#!/bin/bash
NAME="hello_django"                                 # Name of the application
USER="hello"                                        # the user to run as
GROUP="webapps"                                     # the group to run as
REPO="https://github.com/johnrlive/django-server"   # Git repository

cd /$GROUP/$NAME/
virtualenv . 
source bin/activate

echo '#########################################'
echo '#    Installs django within virtualenv  #'
echo '#########################################'
sleep 1
pip install django
echo 'your environment with django should be ready to use. go ahead and create an empty django project.'
sleep 1

django-admin.py startproject $USER 
# uncomment this to test django is created
# cd $USER 
# python manage.py runserver example.com:8000

echo '#########################################'
echo '#            Pillow installed           #'
echo '#########################################'
sleep 1
pip install pillow
#
#
##############################################################################################
#
#
echo '#########################################'
echo '#  psycopg2 database adapter installed  #'
echo '#########################################'
sleep 1
pip install psycopg2
#
#
##############################################################################################
#
#
echo '#########################################'
echo '#        [START Gunicorn INSTALL]       #'
echo '#########################################'
sleep 1
pip install gunicorn
#
##############################################################################################
#
#
echo '#########################################'
echo '#        Setproctitle installed         #'
echo '#########################################'
sleep 1
pip install setproctitle
#
#
##############################################################################################
#
#
echo '====== run: bash install_part3.sh'
sleep 1


