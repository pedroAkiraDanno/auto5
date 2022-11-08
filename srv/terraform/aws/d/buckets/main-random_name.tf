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

resource "random_id" "my-random-id" {
byte_length = 4
}

output "id" {
  value = random_id.my-random-id.id
}



resource "aws_s3_bucket" "s3_bucket" {
  bucket = "s3_bucket-${random_id.my-random-id.dec}"  
}

resource "aws_s3_bucket_public_access_block" "s3_block" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}



/*REFERENCES: 
  https://subscription.packtpub.com/book/cloud-and-networking/9781800201538/16/ch16lvl1sec92/choosing-an-aws-bucket-name-and-how-to-create-a-random-bucket-name
  https://thecloudbootcamp.notion.site/Hands-on-with-AWS-and-Terraform-f03e78550854400581f519b458f680e7
  https://stackoverflow.com/questions/73340706/modifying-s3-bucket-created-by-random-id-in-terraform
  https://www.terraform.io/downloads

*/


/*exec: 
  terraform init
  terraform plan
  terraform apply
*/
