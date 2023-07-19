source common.sh

echo -e "${color} Disabling the current ${component} module ${nocolor}"
yum module disable mysql -y &>> ${log_file}
stat_check $?

echo -e "${color} copying mysql repo file ${nocolor}"
cp /home/centos/Roboshop-Shell/mysql.repo /etc/yum.repos.d/mysql.repo  &>> ${log_file}
stat_check $?

echo -e "${color} Installing mysql package ${nocolor}"
yum install mysql-community-server -y   &>> ${log_file}
stat_check $?

echo -e "${color} Enabling and starting mysqld service ${nocolor}"
systemctl enable mysqld  &>> ${log_file}
systemctl start mysqld   &>> ${log_file}
stat_check $?

echo -e "${color} Setting password for mysql ${nocolor}"
mysql_secure_installation --set-root-pass  $1  &>> ${log_file}
stat_check $?


