echo -e "\e[31m Downloading erlang repositories \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash   &>> /tmp/roboshop.log

echo -e "\e[31m Downloading rabbitmq repositories \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash  &>> /tmp/roboshop.log

echo -e "\e[31m Installing rabbitmq packages \e[0m"
yum install rabbitmq-server -y   &>> /tmp/roboshop.log

echo -e "\e[31m Enabling and starting rabbitmq server \e[0m"
systemctl enable rabbitmq-server  &>> /tmp/roboshop.log
systemctl start rabbitmq-server   &>> /tmp/roboshop.log

echo -e "\e[31m Adding app user and setting permissions \e[0m"
rabbitmqctl add_user roboshop roboshop123   &>> /tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"   &>> /tmp/roboshop.log