echo "Setting up Nodejs repository"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo "Installing nodejs"
yum install nodejs -y

echo "Adding App user"
useradd roboshop

echo "Creating app directory"
mkdir /app

echo "Downloading catalogue component"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo "Extracting the catalogue content"
cd /app
unzip /tmp/catalogue.zip

echo "Installing Dependencies"
cd /app
npm install

echo "Copying component service file"
cp /home/centos/Roboshop-Shell/catalogue.service  /etc/systemd/system/catalogue.service

echo "Restarting services"
systemctl daemon-reload

systemctl enable catalogue
systemctl start catalogue

echo "Setting up mongo repo file"
cp /home/centos/Roboshop-Shell/mongodb.repo  /etc/yum.repos.d/mongo.repo

echo "Installing MongoDB client"
yum install mongodb-org-shell -y

echo "Loading Schema"
mongo --host mongodb-dev.devopskumar.site </app/schema/catalogue.js

