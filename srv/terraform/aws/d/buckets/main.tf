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
  region  = "us-east-1"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "tcb-app-qa-jr"
}

resource "aws_s3_bucket_public_access_block" "s3_block" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}






/*INSTALL: 
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
    sudo yum -y install terraform
*/




/*exec: 
    cd ~ 
    rm -fr t2 
    rm t* -fr
    mkdir t2 ; cd t2 
    vi main-random_name.tf

    terraform init
    terraform plan
    terraform apply
    terraform apply -auto-approve
*/


/*remove/delete bucket:
      aws s3 ls
      aws s3 rb s3://bucket-name --force

*/




/*REFERENCES: 
  https://thecloudbootcamp.notion.site/Hands-on-with-AWS-and-Terraform-f03e78550854400581f519b458f680e7
  https://www.terraform.io/downloads
  https://docs.aws.amazon.com/AmazonS3/latest/userguide/delete-bucket.html

*/










