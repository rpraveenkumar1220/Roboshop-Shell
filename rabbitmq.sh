source common.sh

echo -e "${color} Downloading erlang repositories ${nocolor}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash   &>> ${log_file}
stat_check $?

echo -e "${color} Downloading rabbitmq repositories ${nocolor}"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash  &>> ${log_file}
stat_check $?

echo -e "${color} Installing rabbitmq packages ${nocolor}"
yum install rabbitmq-server -y   &>> ${log_file}
stat_check $?

echo -e "${color} Enabling and starting rabbitmq server ${nocolor}"
systemctl enable rabbitmq-server  &>> ${log_file}
systemctl start rabbitmq-server   &>> ${log_file}
stat_check $?

echo -e "${color} Adding app user and setting permissions ${nocolor}"
id roboshop &>> ${log_file}
  if [ $? -eq 1 ]; then
  rabbitmqctl add_user roboshop  $1   &>> ${log_file}
  fi
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"   &>> ${log_file}
stat_check $?