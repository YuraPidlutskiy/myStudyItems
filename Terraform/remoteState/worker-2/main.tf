provider "aws" {
    region = "ca-cental-1"
  
}
terraform {
  backend "s3" {
      bucket = "name of bucket"                    # name of exiting bucket
      key = "dev/servers/terraform.tfstate"        # path
      region = "us-east-1"                         # region of this bucket 
  }
}



data "terraform_remote_state" "network" {
  backend = "s3" 
  config = {
    bucket = "bucket name"
    key = "path"
    region = "us-east-1"
   }
}

data "aws_ami" "amazon_latest" {
    owners = ["amazon"]
    most_recent = true
    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}





resource "aws_instance" "web_server" {
    ami = data.aws_ami.amazon_latest
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.example.id]
    subnet_id = data.terraform_remote_state.network.output.public_subnet_ids[0]
    user_data = <<EOF
    #!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http//169.254.169.254/latest/metadata/local-ipv4`
echo "<h2>Web server with Ip $myip</h2><br>Build for example!" > /var/www/html/index/html
sudo service httpd start 
chkconfig httpd on 
    EOF
    tags = {
      "name" = "WebServer"
    }
  
}


resource "aws_security_group" "example" {
    name = "Web server security group"
    vpc_id = data.terraform_remote_state.network.outputs.vpc_id
    ingress =  {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 80
      protocol = "tcp"
      to_port = 80
    } 

    egress = {
      cidr_blocks = [ "0.0.0.0/0" ]
      from_port = 0
      protocol = "-1"
      to_port = 0
    } 
  
}


output "network_details" {
    value = data.terraform_remote_state.network
  
}
output "wev_server_public_ip" {
    value = aws_instance.web_server.public_ip

  
}