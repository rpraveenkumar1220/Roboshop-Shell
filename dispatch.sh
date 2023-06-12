echo "Installing golang packages"
yum install golang -y

echo "Adding the user"
useradd roboshop

echo "Creating app directory"
mkdir /app

echo "Downloading dispatch component"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip

echo "Extracting the dispatch content"
cd /app
unzip /tmp/dispatch.zip

echo "Setting up Application directory"
cd /app
go mod init dispatch
go get
go build

echo "Copying component service file"
cp /home/centos/Roboshop-Shell/dispatch.service /etc/systemd/system/dispatch.service

echo "Restarting services"
systemctl daemon-reload

systemctl enable dispatch
systemctl start dispatch