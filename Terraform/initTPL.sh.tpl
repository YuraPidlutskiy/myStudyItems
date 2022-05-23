#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http//169.254.169.254/latest/metadata/local-ipv4`
cat <<EOF > /var/http/html/index.html
<html>
<h2>Build by Terraform <font color="red">v0.12</h2><br>
owner ${myName}<br>

%{ for x in names ~}
Hello to ${x} from ${myName}<br>
%{ endfor ~ }




</html>
EOF

sudo service httpd start
chkconfig httpd on 