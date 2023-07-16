echo -e "\e[31m Copying the mongodb repo file \e[0m"
cp /home/centos/Roboshop-Shell/mongodb.repo  /etc/yum.repos.d/mongo.repo  &>> /tmp/roboshop.log

echo -e "\e[31m Installing mongodb packages \e[0m"
yum install mongodb-org -y   &>> /tmp/roboshop.log

echo  -e "\e[31m Enabling and starting  mongod service \e[0m"
systemctl enable mongod  &>> /tmp/roboshop.log
systemctl start mongod  &>> /tmp/roboshop.log

echo  -e "\e[31m Editing the port \e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf   &>> /tmp/roboshop.log

echo -e "\e[31m restarting mongod service \e[0m"
systemctl restart mongod   &>> /tmp/roboshop.log