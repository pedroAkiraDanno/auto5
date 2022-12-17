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
resource "random_id" "my-random-id" {
  byte_length = 2
}

resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "${var.s3_bucket_name}-${random_id.my-random-id.dec}"
  acl = "private"
  versioning {
    enabled = true
  }
  tags =  {
      Name = "21-days-of-aws-using-terraform"
  }
}