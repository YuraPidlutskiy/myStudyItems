resource "aws_security_group" "web_server" {
  name        = "web server"
  description = "security group for web server "
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
      for_each = ["80", "443" , "8080", "3000"]
      content {
         from_port        = ingress.value
         to_port          = ingress.value
         protocol         = "tcp"
         cidr_blocks      = ["0.0.0.0/0"]         
      }
  }  # dynamic ingress rule 

  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["10.10.0.0/16"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

#for crate subnet use by data
data "aws_availability_zones" "working" {}
data "aws_caller_indentity" "current" {}
data "aws_region" "current" {}
data "aws_vpcs" "myvpcs" {}

data "aws_vpc" "xt_vpc" {
    tags = {
        Name = "prod"
    }
}

resource "aws_subnet" "subnet1" {
    vpc_id = data.aws_vpc.my_vpc.id
    availability_zone = data.aws_availability_zones.working.names[0]
    cidr_block = "10.10.0.0/24"

    tags = {
      "name" = "sub-1"
    }
  
}
resource "aws_subnet" "subnet2" {
    vpc_id = data.aws_vpc.my_vpc.id
    availability_zone = data.aws_availability_zones.working.names[0]
    cidr_block = "10.10.0.0/24"

    tags = {
      "name" = "sub-2"
    }
  
}