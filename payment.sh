echo -e "\e[31m Installing python package \e[0m"
yum install python36 gcc python3-devel -y   &>> /tmp/roboshop.log

echo -e "\e[31m Adding application user \e[0m"
useradd  roboshop   &>> /tmp/roboshop.log

echo -e "\e[31m creating Application directory \e[0m"
mkdir /app   &>> /tmp/roboshop.log

echo -e "\e[31m Downloading Payment component \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip  &>> /tmp/roboshop.log

echo -e "\e[31m extracting the payment component \e[0m"
cd /app
unzip /tmp/payment.zip  &>> /tmp/roboshop.log

echo -e "\e[31m installing dependencies \e[0m"
cd /app
pip3.6 install -r requirements.txt  &>> /tmp/roboshop.log

echo -e "\e[31m Setting up payment service file \e[0m"
cp /home/centos/Roboshop-Shell/payment.service  /etc/systemd/system/payment.service  &>> /tmp/roboshop.log

echo -e "\e[31m Reloading the process \e[0m"
systemctl daemon-reload   &>> /tmp/roboshop.log

echo -e "\e[31m Enabling and starting the payment service \e[0m"
systemctl enable payment   &>> /tmp/roboshop.log
systemctl start payment   &>> /tmp/roboshop.log

