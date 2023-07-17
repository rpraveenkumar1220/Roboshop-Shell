source common.sh
component=mongodb

echo -e "${color} Copying the ${component} repo file ${nocolor}"
cp /home/centos/Roboshop-Shell/${component}.repo  /etc/yum.repos.d/mongo.repo  &>> ${log_file}

echo -e "${color} Installing ${component} packages ${nocolor}"
yum install ${component}-org -y   &>> ${log_file}

echo  -e "${color} Enabling and starting  mongod service ${nocolor}"
systemctl enable mongod  &>> ${log_file}
systemctl start mongod  &>> ${log_file}

echo  -e "${color} Editing the port ${nocolor}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf   &>> ${log_file}

echo -e "${color} restarting mongod service ${nocolor}"
systemctl restart mongod   &>> ${log_file}