#!/bin/bash
sudo yum update -y
sudo yum install httpd -y

TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`

#instanceId=$(curl http://169.254.169.254/latest/meta-data/instance-id)
instanceId=$(curl http://169.254.169.254/latest/meta-data/instance-id -H "X-aws-ec2-metadata-token: $TOKEN")

echo "<h1>$instanceId – Pedro Modena </h1>" > /var/www/html/index.html

sudo service httpd start