#!/bin/bash
NAME="hello_django"                                 # Name of the application
USER="hello"                                        # the user to run as
GROUP="webapps"                                     # the group to run as
REPO="https://github.com/johnrlive/django-server"   # Git repository
# DJANGODIR=/webapps/$NAME/$USER                    # Django project directory
# SOCKFILE=/webapps/$NAME/run/gunicorn.sock         # we will communicte using this unix socket
# NUM_WORKERS=3                                     # how many worker processes should Gunicorn spawn
# DJANGO_SETTINGS_MODULE=$USER.settings             # which settings file should Django use
# DJANGO_WSGI_MODULE=$USER.wsgi                     # WSGI module name

script_runner=$(whoami)

if [ $script_runner == "root" ] ; then
  echo -e "\nFor security reasons this script must be run as a normal user with sudo privileges\n"
  exit 1
fi

clear
# echo '[Welcome to django-server]'
# echo '(setup can take more 5 minutes)'
#
# #### START install prerequisite
# echo '[###### START Prerequisite ######]'
# sleep 1
# sudo aptitude -y update && sudo aptitude -y upgrade
echo '[###### install linux tools ######]'
sleep 1
sudo aptitude -y install git mc supervisor nginx

echo '[###### install python-dev packages ######]'
sleep 1
sudo aptitude -y install python-dev python-setuptools python-virtualenv

echo '[###### install database packages tools ######]'
sleep 1
sudo aptitude -y install postgresql postgresql-contrib libpq-dev

echo '[###### packages for Pillow egg to work ######]'
sleep 1
sudo aptitude -y install libtiff5-dev libjpeg8-dev zlib1g-dev \
    libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk

echo '[###### START INSTALL PIPS ######]'
sleep 1

sudo pip install django
echo '#######  Django installed ######'
sleep 1

sudo pip install pillow
echo '###### Pillow installed ######'
sleep 1

sudo pip install wagtail
echo '###### Wagtail installed ######'
sleep 1

sudo pip install psycopg2
echo '###### Psycopg2 database adapter installed ######'
sleep 1

sudo pip install setproctitle
echo '######  Setproctitle installed ######'
sleep 1

sudo pip install gunicorn
echo '###### Gunicorn installed ######'
sleep 1

echo '[###### DONE Prerequisite ######]'
sleep 1

##### END install prerequisitei

echo 'Create and activate an environment for your application

I like to keep all my web apps in the /webapps/ directory. If you prefer /var/www/, /srv/ or something else, use that instead. Create a directory to store your application in /webapps/hello_django/ and change the owner of that directory to your application user hello'
sleep 1
sudo mkdir -p /webapps/$NAME/
sudo chown $USER /webapps/$NAME/
sleep 1

sudo su - hello
cd /webapps/$NAME/
virtualenv .
source bin/activate
django-admin.py startproject $USER



# echo '[##### START Setup for Application User]'
# # Even though Django has a pretty good security track record, web applications can become compromised. If the application has limited access to resources on your server, potential damage can also be limited. Your web applications should run as system users with limited privileges.
# # Create a user for your app, named hello and assigned to a system group called webapps.
# sleep 1
# sudo groupadd --system $GROUP
# # echo '# example: sudo groupadd --system webapps'
#
# sudo useradd --system --gid $GROUP --shell /bin/bash --home /$GROUP/$NAME $USER
# # echo '# sudo useradd --system --gid webapps --shell /bin/bash --home /webapps/hello_django hello'
#
# echo '[###### Create and activate an environment for your application ######]'
# # I like to keep all my web apps in the /webapps/ directory. If you prefer /var/www/, /srv/ or something else, use that instead. Create a directory to store your application in /webapps/hello_django/ and change the owner of that directory to your application user hello
#
# sudo mkdir -p /$GROUP/$NAME/
# echo '# sudo mkdir -p /webapps/hello_django/'
#
# sudo chown $USER /$GROUP/$NAME/
# echo '#sudo chown hello /webapps/hello_django/'
#
# sleep 1
# echo '[####### Application User DONE ######]'
# sleep 1


# [###### START Install virtualenv and create an environment for you app #####]
# Virtualenv is a tool which allows you to create separate Python environments on your system. This allows you to run applications with different sets of requirements concurrently (e.g. one based on Django 1.5, another based on 1.6). virtualenv is easy to install on Debian:
# sudo aptitude -y install python-virtualenv










### CODE ABOVE: Is working ###

################################### BREAK ##########################################

### CODE BELOW: NEEDS MANUAL Proccess  ###

# ##### START install PostgreSQL
# echo '[###### Install Postgres ######]'
# sleep 1
#
# echo '#### Login into postgres as superuser'
# echo '==== type: sudo su - postgres'
# sleep 1
#
# echo '#### Createuser in Postgres'
# echo '==== type: createuser --interactive -P'
# sleep 1
#
# echo '# example:'
# echo '# Enter name of role to add: hello_django'
# echo '# Enter password for new role: [blank]'
# echo '# Enter it again: [blank]'
# echo '# Shall the new role be a superuser? (y/n) n'
# echo '# Shall the new role be allowed to create databases? (y/n) n'
# echo '# Shall the new role be allowed to create more new roles? (y/n) n'
# sleep 1
#
# echo '==== type: createdb --owner $NAME $USER'
# echo '# example: createdb --owner hello_django hello'
# sleep 1
#
# echo '==== type: logout'
# echo '# this logs out of postgres shell'
# echo '[###### Postgress Install Done ######]'
# sleep 1
1
1
1
Postgress Install Done ######]'
# sleep 1
1
1
1

1
