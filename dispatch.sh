source common.sh
component=dispatch
rabbitmq_password=$1
if [ -z "$rabbitmq_password" ]; then
  echo "rabbitmq_password is missing"
  exit 1
fi

golang