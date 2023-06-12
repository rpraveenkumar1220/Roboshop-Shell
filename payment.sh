echo "Installing python package"
yum install python36 gcc python3-devel -y

echo "Adding application user"
useradd roboshopuseradd roboshop

echo "creating Application directory"
mkdir /app

echo "Downloading Payment component"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip

echo "extracting the payment component"
cd /app
unzip /tmp/payment.zip

echo "installing dependencies"
cd /app
pip3.6 install -r requirements.txt

echo "Setting up payment service file"
cp /DevopsTraining/Roboshop-Shell/payment.service  /etc/systemd/system/payment.service

echo "Reloading the process"
systemctl daemon-reload

echo "Enabling and starting the payment service"
systemctl enable payment
systemctl start payment

