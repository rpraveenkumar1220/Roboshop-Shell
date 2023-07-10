echo "Disabling the current mysql module"
yum module disable mysql -y

echo "copying mysql repo file"
cp /home/centos/Roboshop-Shell/mysql.repo /etc/yum.repos.d/mysql.repo

echo "Installing mysql package"
yum install mysql-community-server -y

echo "Enabling and starting mysqld service"
systemctl enable mysqld
systemctl start mysqld

echo "Setting password for mysql"
mysql_secure_installation --set-root-pass RoboShop@1

echo "Connecting to DB to check the password Authentication"
mysql -uroot -pRoboShop@1


