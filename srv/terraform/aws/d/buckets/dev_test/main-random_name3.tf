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


resource "aws_s3_bucket_public_access_block" "devops_bucket" {
  bucket = aws_s3_bucket.devops_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}




