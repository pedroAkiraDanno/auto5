terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}


resource "random_id" "s3_id" {
    byte_length = 2
}


resource "aws_s3_bucket" "devops_bucket" {
  bucket = "devops-bucket-${random_id.s3_id.dec}"
  
  tags = {
      Env = "dev"
      Service = "s3"
      Team = "devops"
  }
}


