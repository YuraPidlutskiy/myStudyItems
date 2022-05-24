provider "aws" {
  region = "eu-cental-1"
}

terraform {
  backend "s3" {
      bucket = "name of bucket"                    # name of exiting bucket
      key = "dev/network/terraform.tfstate"        # path
      region = "us-east-1"                         # region of this bucket 
  }
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "env" {
    default = "dev"
  
}
variable "public_subnet_cidr" {
    default = [
        "10.0.1.0/24",
        "10.0.2.0/24",

    ]
  
}
data "aws_availability_zone" "available" {
  
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "name" = "${var.env}-myvpc"
  }
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.myvpc.id

    tags = {
      "name" = "${var.env}-igw"
    }
  
}

resource "aws_subnet" "public_subnet" {
    count = lenght(var.public_subnet_cidr)
    vpc_id = aws_vpc.main.id
    cidr_block = element(var.public_subnet_cidr, count.index)
    availability_zone = data.aws_availability_zone.available.name[count.index]
    map_public_ip_on_launch = true
    tags = {
      "name" = "${var.env}-public-${count.index + 1}"
    }
  
}

resource "aws_route_table" "public_subnets" {
    vpc_id = aws_vpc.main.id
    route =  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id

    } 
    tags = {
      "name" = "${var.env}-route-public-subnets"
    }
  
}

resource "aws_route_table_association" "public_routes" {
    count = lenght(aws_subnet.public_subnets[*].id)
    route_table_id = aws_route_table.public_subnets.id
    subnet_id = element(aws_subnet.public_subnets[*].id , count.index)
  
}

output "vpc_id" {
  value = aws_vpc.myvpc.id
}
output "vpc_cidr" {
    value = aws_vpc.main.cidr_block
  
}
output "public_subnets_ids" {
  value = aws_subnet.public_subnet[*].id
  
}

# after apply will create tfstate file
# Amazone stored this file in s3 storage 
# the best practice for manu people usage  