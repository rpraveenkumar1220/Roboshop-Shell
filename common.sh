color="\e[35m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
user_id=$(id -u)
if [ $user_id -ne 0 ]; then
  echo script should be running with root user
  exit 1
fi

stat_check(){
  if [ $1 -eq 0 ]; then
    echo  Success
  else
    echo Failure
  exit 1
  fi
}
nodejs(){
  echo -e "${color}  Downloading and setting up  rpm ${nocolor}"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>> ${log_file}
  stat_check $?
  echo  -e "${color} Installing the nodejs Package ${nocolor}"
  yum install nodejs -y  &>> ${log_file}
  stat_check $?
  app_setup

  echo -e "${color} Installing Dependencies ${nocolor}"
    cd /app  &>> ${log_file}
    npm install  &>> ${log_file}
    stat_check $?
  component_setup
  services_setup
}

app_setup(){
  echo -e "${color} Adding the user ${nocolor}"
  id roboshop &>> ${log_file}
  if [ $? -eq 1 ]; then
  useradd roboshop  &>> ${log_file}
  fi
  stat_check $?

  echo  -e "${color} Creating the Directory ${nocolor}"
  cd /app &>> ${log_file}
  if [ $? -eq 1 ];then
  mkdir /app  &>> ${log_file}
  fi
  stat_check $?

  echo -e "${color} Downloading the ${component} component ${nocolor}"
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip  &>> ${log_file}
  stat_check $?

  echo  -e "${color} Extracting the ${component} component ${nocolor}"
  cd /app  &>> ${log_file}
  unzip /tmp/${component}.zip  &>> ${log_file}
  stat_check $?
}


services_setup(){
  echo -e "${color} Copying the Service file ${nocolor}"
  cp /home/centos/Roboshop-Shell/${component}.service /etc/systemd/system/${component}.service  &>> ${log_file}
  if [ ${component} == payment ]; then
    sed -i 's/rabbitmq_password/${rabbitmq_password}/'   /etc/systemd/system/${component}.service
  fi
  stat_check $?

  echo -e "${color} Restarting services ${nocolor}"
  systemctl daemon-reload  &>> ${log_file}
  systemctl enable ${component}  &>> ${log_file}
  systemctl start ${component}  &>> ${log_file}
  stat_check $?
}


mongodb_setup(){
  echo -e "${color} Setting up MongoDB Repo ${nocolor}"
  cp /home/centos/Roboshop-Shell/mongodb.repo  /etc/yum.repos.d/mongo.repo  &>> ${log_file}
  stat_check $?

  echo -e "${color} Installing MongoDB client  ${nocolor}"
  yum install mongodb-org-shell -y   &>> ${log_file}
  stat_check $?

  echo -e "${color} Loading Schema ${nocolor}"
  mongo --host mongodb-dev.devopskumar.site </app/schema/${component}.js  &>> ${log_file}
  stat_check $?
}

golang(){
  echo -e "${color} Installing golang packages ${nocolor}"
  yum install golang -y  &>> ${log_file}
  stat_check $?

  app_setup

  echo -e "${color} Setting up Application directory ${nocolor}"
  cd /app  &>> ${log_file}
  go mod init ${component}  &>> ${log_file}
  go get  &>> ${log_file}
  go build  &>> ${log_file}
  stat_check $?

  services_setup
}

python(){
  echo -e "${color} Installing python package ${color}"
  yum install python36 gcc python3-devel -y   &>> ${log_file}
  stat_check $?

  app_setup

  echo -e "${color} installing dependencies ${color}"
  cd /app
  pip3.6 install -r requirements.txt  &>> ${log_file}
  stat_check $?

  services_setup
}


maven(){
  echo -e "${color} Installing maven package ${nocolor}"
  yum install maven -y   &>> /tmp/roboshop.log
   stat_check $?

  app_setup

  echo -e "${color} Installing Dependecies ${nocolor}"
  cd /app
  mvn clean package   &>> /tmp/roboshop.log
  mv target/${component}-1.0.jar ${component}.jar   &>> /tmp/roboshop.log
  stat_check $?

  mysql_setup
  services_setup

}

mysql_setup(){
  echo -e "${color} Installing Mysql client${nocolor}"
  yum install mysql -y   &>> /tmp/roboshop.log
  stat_check $?

  echo -e "${color}checking user and password authentication${nocolor}"
  mysql -h mysql-dev.devopskumar.site -uroot -p$mysql_password < /app/schema/${component}.sql   &>> /tmp/roboshop.log
  stat_check $?

  echo -e "${color}Restarting ${component} service ${nocolor}"
  systemctl restart ${component}   &>> /tmp/roboshop.log
}
