echo "Setting up rpm"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo  "Installing the nodejs Package"
yum install nodejs -y

echo "Adding the user"
useradd roboshop

echo "Creating the Directory"
mkdir /app

echo "Downloading the cart component"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip

echo "Extracting the cart component"
cd /app
unzip /tmp/cart.zip

echo "Installing Dependencies"
cd /app
npm install

echo "Copying the Service file"
cp /DevOps\ Training/GitHub-Repos/Roboshop-Shell/cart.service /etc/systemd/system/cart.service

echo "Restarting services"
systemctl daemon-reload

systemctl enable cart
systemctl start cart