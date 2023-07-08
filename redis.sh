echo "Installing redis rpm"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

echo "Enabling redis module"
yum module enable redis:remi-6.2 -y

echo "Installing redis package"
yum install redis -y

echo "Changing ports"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf  /etc/redis/redis.conf


echo "Enabling and starting redis service"
systemctl enable redis
systemctl start redis

