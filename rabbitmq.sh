echo "Downloading erlang repositories"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo "Downloading rabbitmq repositories"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo "Installing rabbitmq packages"
yum install rabbitmq-server -y

echo "Enabling and starting rabbitmq server"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

echo "Adding app user and setting permissions"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"