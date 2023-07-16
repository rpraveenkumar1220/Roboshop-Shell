color="\e[31m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
component=cart

echo -e "${color}  Downloading and setting up  rpm ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>> ${log_file}

echo  -e "${color} Installing the nodejs Package ${nocolor}"
yum install nodejs -y  &>> ${log_file}

echo -e "${color} Adding the user ${nocolor}"
useradd roboshop  &>> ${log_file}

echo  -e "${color} Creating the Directory ${nocolor}"
mkdir /app  &>> ${log_file}

echo -e "${color} Downloading the cart component ${nocolor}"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip  &>> ${log_file}

echo  -e "${color} Extracting the cart component ${nocolor}"
cd /app  &>> ${log_file}
unzip /tmp/cart.zip  &>> ${log_file}

echo -e "${color} Installing Dependencies ${nocolor}"
cd /app  &>> ${log_file}
npm install  &>> ${log_file}

echo -e "${color} Copying the Service file ${nocolor}"
cp /home/centos/Roboshop-Shell/cart.service /etc/systemd/system/cart.service  &>> ${log_file}

echo -e "${color} Restarting services ${nocolor}"
systemctl daemon-reload  &>> ${log_file}
systemctl enable cart  &>> ${log_file}
systemctl start cart  &>> ${log_file}