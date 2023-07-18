source common.sh

echo -e "${color} Disabling the current ${component} module ${nocolor}"
yum module disable mysql -y   &>> /tmp/roboshop.log

echo -e "${color} copying mysql repo file ${nocolor}"
cp /home/centos/Roboshop-Shell/mysql.repo /etc/yum.repos.d/mysql.repo  &>> /tmp/roboshop.log

echo -e "${color} Installing mysql package ${nocolor}"
yum install mysql-community-server -y   &>> /tmp/roboshop.log

echo -e "${color} Enabling and starting mysqld service ${nocolor}"
systemctl enable mysqld  &>> /tmp/roboshop.log
systemctl start mysqld   &>> /tmp/roboshop.log

echo -e "${color} Setting password for mysql ${nocolor}"
mysql_secure_installation --set-root-pass  $1  &>> /tmp/roboshop.log

echo -e "${color} Connecting to DB to check the password Authentication ${nocolor}"
mysql -uroot -pRoboShop@1   &>> /tmp/roboshop.log


