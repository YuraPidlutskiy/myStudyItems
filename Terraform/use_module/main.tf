provider "aws" {
  region = "us-east-1"
}


module "vpc-staging" {
  source = "../VPC/modules/aws_network"
}

module "vpc-prod" {
  source = "../VPC/modules/aws_network"
  env = "production"
  vpc_cidr = "10.100.0.0/16"
  public_subnet_cidr = ["10.100.1.0/24","10.100.2.0/24"]
  private_subnet_cidrs = ["10.100.11.0/24", "10.100.12.0/24"]
}


output "prod_public_subnet_ids" {
  value = module.vpc-prod.public-subnet_ids 
      
}