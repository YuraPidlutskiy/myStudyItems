terraform {

  required_providers {

    aws = {

      source = "hashicorp/aws"

    }

  }

  required_version = ">= 0.12"

}

provider "aws" {

  profile = "default"

  region  = "us-east-1"

}

resource "aws_s3_bucket" "b" {

  bucket = "my_s3_bucket"

  acl    = private

}