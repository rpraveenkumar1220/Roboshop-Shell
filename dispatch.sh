echo -e "\e[31m Installing golang packages \e[0m"
yum install golang -y  &>> /tmp/roboshop.log

echo  -e "\e[31m Adding the user \e[0m"
useradd roboshop  &>> /tmp/roboshop.log

echo  -e "\e[31m Creating app directory \e[0m"
mkdir /app  &>> /tmp/roboshop.log

echo -e "\e[31m Downloading dispatch component \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip  &>> /tmp/roboshop.log

echo  -e "\e[31m Extracting the dispatch content \e[0m"
cd /app   &>> /tmp/roboshop.log
unzip /tmp/dispatch.zip  &>> /tmp/roboshop.log

echo -e "\e[31m Setting up Application directory \e[0m"
cd /app  &>> /tmp/roboshop.log
go mod init dispatch  &>> /tmp/roboshop.log
go get  &>> /tmp/roboshop.log
go build  &>> /tmp/roboshop.log

echo -e "\e[31m Copying component service file \e[0m"
cp /home/centos/Roboshop-Shell/dispatch.service /etc/systemd/system/dispatch.service  &>> /tmp/roboshop.log

echo -e "\e[31m Restarting services \e[0m"
systemctl daemon-reload  &>> /tmp/roboshop.log

systemctl enable dispatch  &>> /tmp/roboshop.log
systemctl start dispatch  &>> /tmp/roboshop.log