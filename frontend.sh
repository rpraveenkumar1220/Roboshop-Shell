source common.sh
component=frontend

echo -e "${color} Installing Nginx Server ${nocolor}"
yum install nginx -y  &>> ${log_file}

echo -e "${color}Enabling and starting nginix service ${nocolor}"
systemctl enable nginx  &>> ${log_file}
systemctl start nginx   &>> ${log_file}

echo -e "${color} Removing the default front page content of server ${nocolor}"
rm -rf /usr/share/nginx/html/*   &>> ${log_file}

echo -e "${color} Downloading the ${component} content ${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip  &>> ${log_file}

echo -e "${color} Extracting the ${component} content ${nocolor}"
cd /usr/share/nginx/html   &>> ${log_file}
unzip /tmp/${component}.zip    &>> ${log_file}

echo -e "${color} Configuring the ${component} ${nocolor}"
cp  /home/centos/Roboshop-Shell/roboshop.conf  /etc/nginx/default.d/roboshop.conf  &>> ${log_file}

echo -e "${color} restarting the nginx ${nocolor}"
systemctl restart nginx  &>> ${log_file}