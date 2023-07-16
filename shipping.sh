echo -e "\e[31m Installing maven package \e[0m"
yum install maven -y   &>> /tmp/roboshop.log

echo  -e "\e[31m Adding app user and creating directory \e[0m"
useradd roboshop   &>> /tmp/roboshop.log
mkdir /app    &>> /tmp/roboshop.log

echo -e "\e[31m Downloading and extracting Shipping component \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip   &>> /tmp/roboshop.log
cd /app
unzip /tmp/shipping.zip   &>> /tmp/roboshop.log

echo -e "\e[31m Installing Dependecies \e[0m"
cd /app
mvn clean package   &>> /tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar   &>> /tmp/roboshop.log

echo -e "\e[31m Copying service file \e[0m"
cp /home/centos/Roboshop-Shell/shipping.service /etc/systemd/system/shipping.service   &>> /tmp/roboshop.log

echo -e "\e[31m Restarting daemon \e[0m"
systemctl daemon-reload   &>> /tmp/roboshop.log

echo -e "\e[31m Enabling and starting service \e[0m"
systemctl enable shipping   &>> /tmp/roboshop.log
systemctl start shipping   &>> /tmp/roboshop.log

echo -e "Installing Mysql client"
yum install mysql -y   &>> /tmp/roboshop.log

echo -e "checking user and password authentication"
mysql -h mysql-dev.devopskumar.site -uroot -pRoboShop@1 < /app/schema/shipping.sql   &>> /tmp/roboshop.log

echo -e "Restarting Shipping service"
systemctl restart shipping   &>> /tmp/roboshop.log

