#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http//169.254.169.254/latest/metadata/local-ipv4`
echo "<h2>Web server with Ip $myip</h2><br>Build for example!" > /var/www/html/index/html
sudo service httpd start 
chkconfig httpd on 
