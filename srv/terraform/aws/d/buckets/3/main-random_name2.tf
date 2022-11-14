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
  region = "us-east-1"
}


resource "random_id" "s3_id" {
    byte_length = 4
}



resource "aws_s3_bucket" "s3_bucket" {
  bucket = "s3bucket-${random_id.s3_id.dec}"

  tags = {
      Env = "dev"
      Service = "s3"
      Team = "devops"
  }
}


/*
resource "aws_s3_bucket_public_access_block" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
*/




/*INSTALL: 
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
    sudo yum -y install terraform
*/




/*exec: 
    cd ~ 
    rm t* -fr    
    rm -fr t1 
    mkdir t1 ; cd t1 
    vi main-random_name.tf

    terraform init
    terraform plan
    terraform apply
    terraform apply -auto-approve
*/



/*REFERENCES: 
  https://subscription.packtpub.com/book/cloud-and-networking/9781800201538/16/ch16lvl1sec92/choosing-an-aws-bucket-name-and-how-to-create-a-random-bucket-name
  https://thecloudbootcamp.notion.site/Hands-on-with-AWS-and-Terraform-f03e78550854400581f519b458f680e7
  https://stackoverflow.com/questions/73340706/modifying-s3-bucket-created-by-random-id-in-terraform
  https://tianzhui.cloud/post/dulmsel3/
  https://www.terraform.io/downloads
  


  https://www.cloudforecast.io/blog/terraform-s3-bucket-aws-tags/

*/
