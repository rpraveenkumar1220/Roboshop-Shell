echo -e "\e[31m Disabling the current mysql module \e[0m"
yum module disable mysql -y   &>> /tmp/roboshop.log

echo -e "\e[31m copying mysql repo file \e[0m"
cp /home/centos/Roboshop-Shell/mysql.repo /etc/yum.repos.d/mysql.repo  &>> /tmp/roboshop.log

echo -e "\e[31m Installing mysql package \e[0m"
yum install mysql-community-server -y   &>> /tmp/roboshop.log

echo -e "\e[31m Enabling and starting mysqld service \e[0m"
systemctl enable mysqld  &>> /tmp/roboshop.log
systemctl start mysqld   &>> /tmp/roboshop.log

echo -e "\e[31m Setting password for mysql \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1   &>> /tmp/roboshop.log

echo -e "\e[31m Connecting to DB to check the password Authentication \e[0m"
mysql -uroot -pRoboShop@1   &>> /tmp/roboshop.log


