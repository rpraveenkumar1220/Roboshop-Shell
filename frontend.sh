echo -e "\e[31m Installing Nginx Server \e[0m"
yum install nginx -y  &>> /tmp/roboshop.log

echo -e "\e[31mEnabling and starting nginix service \e[0m"
systemctl enable nginx  &>> /tmp/roboshop.log
systemctl start nginx   &>> /tmp/roboshop.log

echo -e "\e[31m Removing the default front page content of server \e[0m"
rm -rf /usr/share/nginx/html/*   &>> /tmp/roboshop.log

echo -e "\e[31m Downloading the frontend content \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip  &>> /tmp/roboshop.log

echo -e "\e[31m Extracting the frontend content \e[0m"
cd /usr/share/nginx/html   &>> /tmp/roboshop.log
unzip /tmp/frontend.zip    &>> /tmp/roboshop.log

echo -e "\e[31m Configuring the frontend \e[0m"
cp  /home/centos/Roboshop-Shell/roboshop.conf  /etc/nginx/default.d/roboshop.conf  &>> /tmp/roboshop.log

echo -e "\e[31m restarting the nginx \e[0m"
systemctl restart nginx  &>> /tmp/roboshop.log