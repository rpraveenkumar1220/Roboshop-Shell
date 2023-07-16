echo -e "\e[31m Downloading rpm \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash   &>> /tmp/roboshop.log

echo -e "\e[31m Installing nodejs packages \e[0m"
yum install nodejs -y   &>> /tmp/roboshop.log

echo -e "\e[31m Adding user and creating directory \e[0m"
useradd roboshop   &>> /tmp/roboshop.log
mkdir /app   &>> /tmp/roboshop.log

echo -e "\e[31m Downloading and extracting user component \e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip   &>> /tmp/roboshop.log
cd /app
unzip /tmp/user.zip  &>> /tmp/roboshop.log

echo -e "\e[31m Installing dependencies \e[0m"
cd /app
npm install  &>> /tmp/roboshop.log

echo -e "\e[31m Setting service files \e[0m"
cp /home/centos/Roboshop-Shell/user.service  /etc/systemd/system/user.service  &>> /tmp/roboshop.log

echo -e "\e[31m Restarting Daemon \e[0m"
systemctl daemon-reload  &>> /tmp/roboshop.log

echo -e "\e[31m Enabling and starting user service \e[0m"
systemctl enable user  &>> /tmp/roboshop.log
systemctl start user  &>> /tmp/roboshop.log

echo -e "\e[31m Setting mongodb repo file \e[0m"
cp /home/centos/Roboshop-Shell/mongodb.repo /etc/yum.repos.d/mongo.repo  &>> /tmp/roboshop.log

echo  -e "\e[31m Installing mongodb client \e[0m"
yum install mongodb-org-shell -y  &>> /tmp/roboshop.log

echo -e "\e[31m Loading schema \e[0m"
mongo --host  mongodb-dev.devopskumar.site </app/schema/user.js  &>> /tmp/roboshop.log