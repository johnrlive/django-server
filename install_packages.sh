#!/bin/bash
NAME="myproject"                                     # Name of the application
USER="ubuntu"                                        # the user to run as
REPO="https://github.com/johnrlive/django-server"    # Git repository

script_runner=$(whoami)
if [ $script_runner == "root" ] ; then
  echo -e "\nFor security reasons this script must be run as a normal user with sudo privileges\n"
  exit 1
fi

echo '(setup can take more 5 minutes)'
sleep 1
echo '===   Update Your System    ==='
sleep 1
sudo apt-get -y update
sudo apt-get -y upgrade

echo '=== Installing Python packages...'
sleep 1
sudo apt-get -y install python-pip python-dev libpq-dev

echo '=== Installing packages for PostreSQL...'
sleep 1
sudo apt-get -y install postgresql postgresql-contrib

echo '=== Installing dependencies for pillow pip...'
sudo apt-get -y install libtiff5-dev libjpeg8-dev zlib1g-dev \
     libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk

echo '=== installing NGINX...'
sleep 1
sudo apt-get -y install nginx

echo '=== Installing utilities...'
sleep 1
sudo apt-get -y install mc vim fail2ban zsh

echo '=== Apt packages completed ==='
sleep 1
clear

echo '=== installing Virtualenv...'
sleep 1
sudo pip install virtualenv

# echo '=== Set ZSH shell as default...'
# sleep 1
# sudo chsh -s $(which zsh)

echo '=== run the following commands ==='
sleep 1
echo '$ mkdir ~/myproject'
sleep 1
echo '$ cd ~/myproject'
sleep 1
echo '$ virtualenv myprojectenv'
sleep 1
echo '$ source myprojectenv/bin/activate'
sleep 1
echo '$ pip install django gunicorn psycopg2 pillow'
sleep 1



# echo '===   Start Services    ==='
# sudo service supervisor start
# sudo service nginx start
