echo -e "\e[31m Downloading and setting up rpm  \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>> /tmp/roboshop.log

echo -e "\e[31m  Installing node js package  \e[0m"
yum install nodejs -y  &>> /tmp/roboshop.log

echo -e "\e[31m  Adding Roboshop user  \e[0m"
useradd roboshop  &>> /tmp/roboshop.log

echo -e "\e[31m Creating App directory \e[0m"
mkdir /app  &>> /tmp/roboshop.log

echo -e "\e[31m Downloading the  catalogue component \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip  &>> /tmp/roboshop.log

echo -e "\e[31m Setting up catalogue component \e[0m"
cd /app   &>> /tmp/roboshop.log
unzip /tmp/catalogue.zip  &>> /tmp/roboshop.log

echo -e "\e[31m Installing dependencies \e[0m"
cd /app  &>> /tmp/roboshop.log
npm install  &>> /tmp/roboshop.log

echo -e "\e[31m Copying Catalogue service file \e[0m"
cp /home/centos/Roboshop-Shell/catalogue.service  /etc/systemd/system/catalogue.service  &>> /tmp/roboshop.log

echo -e "\e[31m Reloading Services  \e[0m"
systemctl daemon-reload  &>> /tmp/roboshop.log

systemctl enable catalogue  &>> /tmp/roboshop.log
systemctl start catalogue   &>> /tmp/roboshop.log

echo -e "\e[31m Setting up MongoDB Repo \e[0m"
cp /home/centos/Roboshop-Shell/mongodb.repo  /etc/yum.repos.d/mongo.repo  &>> /tmp/roboshop.log

echo -e "\e[31m Installing MongoDB client  \e[0m"
yum install mongodb-org-shell -y   &>> /tmp/roboshop.log

echo -e "\e[31m Loading Schema \e[0m"
mongo --host mongodb-dev.devopskumar.site </app/schema/catalogue.js  &>> /tmp/roboshop.log

