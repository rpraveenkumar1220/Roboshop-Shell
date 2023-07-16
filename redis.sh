echo -e "\e[31m Installing redis rpm \e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y  &>> /tmp/roboshop.log

echo -e "\e[31m Enabling redis module \e[0m"
yum module enable redis:remi-6.2 -y  &>> /tmp/roboshop.log

echo -e "\e[31m Installing redis package \e[0m"
yum install redis -y   &>> /tmp/roboshop.log

echo -e "\e[31m Changing ports \e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf  /etc/redis/redis.conf  &>> /tmp/roboshop.log


echo -e "\e[31m Enabling and starting redis service \e[0m"
systemctl enable redis  &>> /tmp/roboshop.log
systemctl start redis   &>> /tmp/roboshop.log

