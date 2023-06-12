echo "Copying the mongodb repo file"
cp /DevopsTraining/Roboshop-Shell/mongodb.repo  /etc/yum.repos.d/mongo.repo

echo "Installing mongodb packages"
yum install mongodb-org -y

echo "Enabling and starting  mongod service"
systemctl enable mongod
systemctl start mongod

echo "Editing the port"
sed -e -i /127.0.0.1/0.0.0.0/ /etc/mongod.conf

echo "restarting mongod service"
systemctl restart mongod