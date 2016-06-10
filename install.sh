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

echo '[Welcome to django-server]'
echo '(setup can take more 5 minutes)'
sleep 1
echo '#########################################'
echo '#      [1] Update Your System           #'
echo '#########################################'
sleep 1
sudo aptitude -y update && sudo aptitude -y upgrade
sudo aptitude -y install python-setuptools

echo 'Install linux tools'
sleep 1
sudo aptitude -y install git mc 

echo '[###### packages for Pillow egg to work ######]'
sleep 1
sudo aptitude -y install libtiff5-dev libjpeg8-dev zlib1g-dev \
    libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python-tk
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
clear
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

sudo groupadd --system $GROUP
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
sudo chown -R $USER /$GROUP/$NAME/
#
#
##############################################################################################
#
#
echo 'as the application user create a virtual python environment in the application directory:'
sudo su - $USER
#
#
##############################################################################################
#
#
echo '[PART 2]'
sleep 1 
cd /$GROUP/$NAME/
virtualenv .
source bin/activate
#
#
##############################################################################################
#
#
echo 'install django within virtualenv'
sleep 1
pip install django
echo 'your environment with django should be ready to use. go ahead and create an empty django project.'
sleep 1
django-admin.py startproject $USER 
# uncomment this to test django is created
# cd $USER 
# python manage.py runserver example.com:8000

echo '###### Pillow installed ######'
sleep 1
pip install pillow


echo 'allowing other users write access to the application directory'
sleep 1
sudo chown -R $USER:users /$GROUP/$NAME
sudo chmod -R g+w /$GROUP/$NAME
id 
sudo usermod -a -G users `whoami`
sleep 2
#
#
##############################################################################################
#
#
echo '###### psycopg2 database adapter installed ######'
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
clear
echo 'Now that you have gunicorn, you can test whether it can serve your Django application by running the following command:'
sleep 1
echo '(hello_django)hello@django:~$ gunicorn hello.wsgi:application --bind example.com:8001
You should now be able to access the Gunicorn server from http://example.com:8001 . I intentionally changed port 8000 to 8001 to force your browser to establish a new connection.'
sleep 1
echo 'Gunicorn is installed and ready to serve your app. Let’s set some configuration options to make it more useful. I like to set a number of parameters, so let’s put them all into a small BASH script, which I save as bin/gunicorn_start'
# unicorn $USER.wsgi:application --bind example.com:8001
echo 'Let’s set some configuration options to make it more useful.'
sleep 1
cp gunicorn_start.bash bin/gunicorn_start 
echo 'Set the executable bit on the gunicorn_start script:'
sleep 1
sudo chmod u+x bin/gunicorn_start
sudo su - $USER
echo 'type this: bin/gunicorn_start'
sleep 1 
bin/gunicorn_start
echo 'should see: Starting hello_app as hello'
#
#
##############################################################################################
#
#
echo '######  Setproctitle installed ######'
sleep 1
pip install setproctitle
#
#
##############################################################################################
#
#
echo 'Starting and monitoring with Supervisor'
sleep 1
sudo aptitude -y install supervisor

echo 'When Supervisor is installed you can give it programs to start and watch by creating configuration files in the /etc/supervisor/conf.d directory. For our hello application we’ll create a file named /etc/supervisor/conf.d/hello.conf with this content:'
sleep 1
cp supervisor.conf.sh /etc/supervisor/conf.d/$NAME.conf

echo 'Create the file to store your application’s log messages:'
sleep 1
mkdir -p /$GROUP/$NAME/logs/
sudo touch /$GROUP/$NAME/logs/gunicorn_supervisor.log 

echo 'After you save the configuration file for your program you can ask supervisor to reread configuration files and update (which will start your the newly registered app).'
sleep 1
sudo supervisorctl reread
sudo supervisorctl update
clear
sudo supervisorctl status $USER 
sudo supervisorctl stop $USER 
sudo supervisorctl start $USER 
sudo supervisorctl restart $USER 
sleep 1
#
#
##############################################################################################
#
#
echo 'Install Nginx'
sleep 1 
sudo aptitude -y install nginx
sudo service nginx start
cp nginx.sh /etc/nginx/sites-available/$NAME
sudo ln -s /etc/nginx/sites-available/$NAME /etc/nginx/sites-enabled/$NAME
sudo service nginx restart
