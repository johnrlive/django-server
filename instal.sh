#!/bin/bash
NAME="firstsite"                                     # Name of the application
USER="ubuntu"                                        # the user to run as
REPO="https://github.com/johnrlive/django-server"    # Git repository

script_runner=$(whoami)
if [ $script_runner == "root" ] ; then
  echo -e "\nFor security reasons this script must be run as a normal user with sudo privileges\n"
  exit 1
fi

echo '(setup can take more 5 minutes)'
sleep 1
echo '===   Updating Your System    ==='
sleep 1
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install aptitude

echo '=== Installing dependencies for pillow egg    ==='
sleep 1
sudo apt-get -y install libtiff5-dev libjpeg8-dev zlib1g-dev \
     libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk

echo '=== Installing packages for PostreSQL   ==='
sleep 1
sudo apt-get -y install postgresql postgresql-contrib libpq-dev

echo '=== Installing utilities    ==='
sleep 1
sudo apt-get -y install mc vim fail2ban

echo '===   Installing Python-pip & Virtualenv   ==='
sleep 1
sudo apt-get -y install python-pip
sudo pip install virtualenv virtualenvwrapper

# change to EOF
# echo "export WORKON_HOME=~/Env" >> ~/.bashrc
# echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
# source ~/.bashrc
# You should now have directory called 'Env' in your home folder which will hold virtual environment information.

# mkvirtualenv firstsite

# Install Pips
# pip install django psycopg2 pillow
# cd ~
# django-admin.py startproject firstsite

echo '===   Installing uWSGI    ==='
sudo apt-get -y install python-dev
sudo pip install uwsgi

# sudo mkdir -p /etc/uwsgi/sites
# sudo cp uwsgi_sites.ini /etc/uwsgi/sites/firstsite.ini
# sudo cp uwsgi.service /etc/systemd/system/uwsgi.service

echo '=== installing NGINX    ==='
sudo apt-get -y install nginx
sudo ufw allow 'Nginx Full'
# sudo cp nginx.sh /etc/nginx/sites-available/firstsite

sudo systemctl restart nginx
sudo systemctl start uwsgi
sudo systemctl enable nginx
sudo systemctl enable uwsgi

# We can quickly test this application server by passing it the information for one of our sites. For instance, we can tell it to serve our first project by typing:
# uwsgi --http :8080 --home /home/ubuntu/Env/firstsite --chdir /home/ubuntu/firstsite -w firstsite.wsgi
