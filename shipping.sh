echo "Installing maven package"
yum install maven -y

echo  "Adding app user and creating directory"
useradd roboshop
mkdir /app

echo "Downloading and extracting Shipping component "
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
unzip /tmp/shipping.zip

echo "Installing Dependecies"
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo "Copying service file"
cp /home/centos/Roboshop-Shell/shipping.service /etc/systemd/system/shipping.service

echo "Restarting daemon"
systemctl daemon-reload

echo "Enabling and starting service"
systemctl enable shipping
systemctl start shipping

echo "Installing Mysql client"
yum install mysql -y

echo "checking user and password authentication"
mysql -h mysql-dev.devopskumar.site -uroot -pRoboShop@1 < /app/schema/shipping.sql

echo "Restarting Shipping service"
systemctl restart shipping

