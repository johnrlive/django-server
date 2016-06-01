#!/bin/bash
NAME="hello_django"                               # Name of the application
USER="hello"                                      # the user to run as
GROUP="webapps"                                   # the group to run as
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

#### START install prerequisite
echo '[###### Update server ######]'
sleep 1
sudo aptitude -y update && sudo aptitude -y upgrade
echo '[###### Done ######]'
sleep 1
#### END install prerequisite

##### START install PostgreSQL
echo '[###### Install Postgres ######]'
sleep 1
sudo aptitude install -y postgresql postgresql-contrib
sudo su - postgres
sleep 1
createuser --interactive -P
sleep 1
createdb --owner $NAME $USER
echo 'createdb --owner hello_django hello'
logout
echo '[###### Postgress Install Done ######]'
sleep 1
##### End install PostgreSQL

##### START Setup for Application User
# Even though Django has a pretty good security track record, web applications can become compromised. If the application has limited access to resources on your server, potential damage can also be limited. Your web applications should run as system users with limited privileges.
#
# Create a user for your app, named hello and assigned to a system group called webapps.
echo '[####### Application User ######]'
sleep 1
sudo groupadd --system $GROUP
echo 'sudo groupadd --system webapps'
sudo useradd --system --gid $GROUP --shell /bin/bash --home /$GROUP/$NAME $USER
echo '# sudo useradd --system --gid webapps --shell /bin/bash --home /webapps/hello_django hello'
echo '[####### Application User DONE ######]'
sleep 1
##### End Setup for Application User
