#!/bin/bash

# This script deploys the Sparta app to a specified environment.
# It installs the necessary dependencies and sets up the environment.
sudo apt-get update &&

sudo apt-get upgrade -y &&

echo Install nginx 
sudo apt-get install nginx -y &&

echo configure nginx
sudo sed -i 's,try_files $uri $uri/ =404;,proxy_pass http://localhost:3000/;,g' /etc/nginx/sites-available/default
sudo systemctl restart nginx


echo install the correct version of nodejs 
sudo bash -c "$(curl -fsSL https://deb.nodesource.com/setup_20.x) | bash -" &&
sudo apt-get install -y nodejs &&

echo install the app dependencies
npm install

#start the app in background using pm2

echo install pm2
sudo npm install pm2@latest -yg &&

echo "stop all running apps just in case (idempotency)"	
pm2 stop all || pm2 start app.js

exit 0
