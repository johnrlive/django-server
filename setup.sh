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

# echo '[Welcome to django-server]'
# echo '(setup can take more 5 minutes)'
# sleep 1
# echo '===   Update Your System    ==='
# sleep 1
# sudo aptitude -y update
# sudo aptitude -y safe-upgrade
# sudo apt-get -y install mc
# sudo apt-get -y install vim
# sudo apt-get -y install fail2ban
# sudo apt-get -y install python-setuptools
# sudo apt-get -y install libpq-dev python-dev
# sudo apt-get -y install postgresql postgresql-contrib
# sudo apt-get -y install libtiff5-dev libjpeg8-dev zlib1g-dev \
#     libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk
# sudo apt-get -y install supervisor
# sudo apt-get -y install nginx

# echo '===   Start Services    ==='
# sudo service supervisor start
# sudo service nginx start

# echo '===   Setup PostgreSQL    ==='
#
# $ sudo su - postgres
# postgres@django:~$ createuser --interactive -P
# Enter name of role to add: hello_django
# Enter password for new role:
# Enter it again:
# Shall the new role be a superuser? (y/n) n
# Shall the new role be allowed to create databases? (y/n) n
# Shall the new role be allowed to create more new roles? (y/n) n
# postgres@django:~$
# postgres@django:~$ createdb --owner hello_django hello
# postgres@django:~$ logout

# ============================================================ #

# $ sudo groupadd --system webapps
# $ sudo useradd --system --gid webapps --shell /bin/bash --home /webapps/hello_django hello

# ============================================================ #

# echo '===   Install python-virtualenv   ==='
# sudo apt-get -y install python-virtualenv

# sudo mkdir -p /webapps/hello_django/
# sudo chown hello /webapps/hello_django/
# sudo chown -R hello:users /webapps/hello_django
# sudo chmod -R g+w /webapps/hello_django

# echo '===   Login into virtualenv   ==='
# sudo su - hello
# mkdir -p /webapps/hello_django/logs/
# touch /webapps/hello_django/logs/gunicorn_supervisor.log
# cd /webapps/hello_django/
# virtualenv .
# source bin/activate

# echo '===   Install pip packages    ==='
# pip install psycopg2
# pip install gunicorn
# pip install setproctitle

# pip install django
# django-admin.py startproject hello
# cd hello
# python manage.py runserver hello.addlocal.com:8000
# exit

# # '===    Setup for Gunicorn    ==='
# # touch /webapps/hello_django/bin/gunicorn_start
# # sudo chmod u+x /webapps/hello_django/bin/gunicorn_start
# # cd /webapps/hello_django/hello/
# # gunicorn hello.wsgi:application --bind example.com:8001

# # '===    Setup for Supervisor    ==='
# sudo touch /etc/supervisor/conf.d/hello.conf
# sudo supervisorctl reread
# sudo supervisorctl update
# sudo supervisorctl restart hello

# # '===    Setup for Nginx    ==='
sudo touch /etc/nginx/sites-available/hello_django
# '===    Copy content from nginx   ==='
sudo ln -s /etc/nginx/sites-available/hello_django /etc/nginx/sites-enabled/hello_django
sudo service nginx restart
