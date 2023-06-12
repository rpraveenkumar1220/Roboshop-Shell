echo "Installing Nginx Server "
yum install nginx -y

echo "Enabling and starting nginix service"
systemctl enable nginx
systemctl start nginx

echo "Removing the default front page content of server"
rm -rf /usr/share/nginx/html/*

echo "Downloading the frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo "Extracting the frontend content"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo "Configuring the frontend"
cp  /home/centos/Roboshop-Shell/roboshop.conf  /etc/nginx/default.d/roboshop.conf

echo "restarting the nginx"
systemctl restart nginx