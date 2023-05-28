yum module disable mysql -y

cp /DevOps\ Training/GitHub-Repos/Roboshop-Shell/mysql.repo /etc/yum.repos.d/mysql.repo

yum install mysql-community-server -y

systemctl enable mysqld
systemctl start mysqld

mysql_secure_installation --set-root-pass RoboShop@1

mysql -uroot -pRoboShop@1

\q

