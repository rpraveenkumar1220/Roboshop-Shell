echo "Downloading rpm"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo "Installing nodejs packages"
yum install nodejs -y

echo "Adding user and creating directory"
useradd roboshop
mkdir /app

echo "Downloading and extracting user component"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip

echo "Installing dependencies"
cd /app
npm install

echo "Setting service files"
cp /DevopsTraining/Roboshop-Shell/user.service  /etc/systemd/system/user.service

echo "Restarting Daemon"
systemctl daemon-reload

echo "Enabling and starting user service"
systemctl enable user
systemctl start user

echo "Setting mongodb repo file"
cp /DevopsTraining/Roboshop-Shell/mongodb.repo /etc/yum.repos.d/mongo.repo

echo "Installing mongodb client"
yum install mongodb-org-shell -y

echo "Loading schema"
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js