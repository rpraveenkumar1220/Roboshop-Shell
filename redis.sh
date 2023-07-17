source common.sh

echo -e "${color} Installing redis rpm ${nocolor}"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y  &>> ${log_file}

echo -e "${color} Enabling redis module ${nocolor}"
yum module enable redis:remi-6.2 -y  &>> ${log_file}

echo -e "${color} Installing redis package ${nocolor}"
yum install redis -y   &>> ${log_file}

echo -e "${color} Changing ports ${nocolor}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf  /etc/redis/redis.conf  &>> ${log_file}


echo -e "${color} Enabling and starting redis service ${nocolor}"
systemctl enable redis  &>> ${log_file}
systemctl start redis   &>> ${log_file}

