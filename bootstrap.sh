#!/bin/bash -ex
# The -e option would make our script exit with an error if any command
# fails while the -x option makes verbosely it output what it does

# Install Pipenv, the -n option makes sudo fail instead of asking for a
# password if we don't have sufficient privileges to run it
sudo -n dnf install -y pipenv
cd /vagrant
pipenv --python 3
pipenv install django
# Install dependencies with Pipenv
pipenv sync
pipenv run django-admin startproject ultimatejob
# run our app. Nohup and "&" are used to let the setup script finish
# while our app stays up. The app logs will be collected in nohup.out
nohup pipenv run python ./manage.py runserver 0.0.0.0:8000 &
#install flake8
pipenv install --dev flake8
#create yaml file for flake8
mkdir -p .github/workflows
echo "all done"