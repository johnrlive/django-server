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

echo '[Welcome to django-server]'
echo '(setup can take more 5 minutes)'
sleep 1
echo '#########################################'
echo '#      [1] Update Your System           #'
echo '#########################################'
sleep 1
sudo aptitude -y update 
sudo aptitude -y safe-upgrade

echo 'Install linux tools'
sleep 1
sudo aptitude -y install python-setuptools
sudo aptitude -y install git mc fail2ban 

echo '[###### packages for Pillow egg to work ######]'
sleep 1
sudo aptitude -y install libtiff5-dev libjpeg8-dev zlib1g-dev \
    libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk

echo '[###### Install Supervisor #######]'
sleep 1
sudo aptitude -y install supervisor

echo '[###### Install Nginx ######]'
sleep 1
sudo aptitude -y install nginx
sudo service nginx start
sudo cp nginx.sh /etc/nginx/sites-available/$NAME
sudo ln -s /etc/nginx/sites-available/$NAME /etc/nginx/sites-enabled/$NAME
sudo service nginx restart
#
#
##############################################################################################
#
#
clear
echo '#########################################'
echo '#    [2]  START POSTGRESQL Install      #'
echo '#########################################'
sleep 1
sudo aptitude -y install postgresql postgresql-contrib libpq-dev python-dev


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
#
#
##############################################################################################
#
#
echo '#########################################'
echo '#  [START Setup for Application User]   #'
echo '#########################################'
sleep 1

# Even though Django has a pretty good security track record, web applications can become compromised. If the application has limited access to resources on your server, potential damage can also be limited. Your web applications should run as system users with limited privileges.
# Create a user for your app, named hello and assigned to a system group called webapps.

sudo delgroup $GROUP 
sudo groupadd --system $GROUP
#sudo deluser --remove-home $USER 
sudo deluser $USER 
sudo useradd --system --gid $GROUP --shell /bin/bash --home /$GROUP/$NAME $USER
#
#
##############################################################################################
#
#
echo 'Install virtualenv and create an environment foryour app'
sleep 1
sudo aptitude -y install python-virtualenv
#
#
##############################################################################################
#
#
echo 'Create and activate an environment for your application I like to keep all my web apps in the /webapps/ directory. If you prefer /var/www/, /srv/ or something else, use that instead.create a directory to store your application in /webapps/hello_django/ and change the owner of that directory to your application user hello'
sleep 1
sudo mkdir -p /$GROUP/$NAME/
sudo chown $USER /$GROUP/$NAME/

#
##############################################################################################
#
#
clear
echo '==== config files from install script ===='
echo 'sudo cp ./install_part2.sh /$GROUP/$NAME/install_part2.sh'
echo 'sudo cp ./install_part3.sh /$GROUP/$NAME/install_part3.sh'
echo 'sudo cp ./gunicorn_start.bash /$GROUP/$NAME/bin/gunicorn_start'
echo 'sudo cp ./supervisor.conf.sh /etc/supervisor/conf.d/$NAME.conf'
sleep 1

sudo cp ./install_part2.sh /$GROUP/$NAME/install_part2.sh
sudo cp ./install_part3.sh /$GROUP/$NAME/install_part3.sh

echo '====== As the application user create a virtual python environment in the application directory:'
echo '====== run: bash install_part2.sh'
sleep 1
sudo su - $USER


