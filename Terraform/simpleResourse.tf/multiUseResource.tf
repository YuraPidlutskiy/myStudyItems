provider "aws" {
  region = "ca-central-1"

  assume_role {                                   # for use another account
    role_arn = "arn:aws:iam::12312312"
    session_name = "Terraform sesion"
  }
}
provider "aws" {
  region = "ua-east-1"
  alias = "USA"
}

provider "aws" {
  region = "eu-cental-1"
  alias = "GER"
}
data "aws_ami" "amazon_latest" {
    owners = ["amazon"]
    most_recent = true
    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}
data "aws_ami" "USA_amazon_latest" {
    provider = aws.USA
    owners = ["amazon"]
    most_recent = true
    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}
data "aws_ami" "GER_amazon_latest" {
    provider = aws.GER
    owners = ["amazon"]
    most_recent = true
    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}
resource "aws_instance" "my_server" {
  instance_type = "t3.micro"
  ami = data.aws_ami.amazon_latest

  tags = {
    "Name" = "Default server"
  }
}
resource "aws_instance" "my_server-1" {
  provider = aws.USA
  instance_type = "t3.micro"
  ami = data.aws_ami.USA_amazon_latest

  tags = {
    "Name" = "USA server"
  }
}
resource "aws_instance" "my_server-2" {
  provider = aws.GER  
  instance_type = "t3.micro"
  ami = data.aws_ami.GER_amazon_latest

  tags = {
    "Name" = "GER server"
  }
}