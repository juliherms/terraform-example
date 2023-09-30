# Fecha a versão do terraform e do provider
terraform {
	required_version = "1.3.4"
		
	required_providers {
		aws = {
			source = "hashicorp/aws"
			version = "5.15.0"
		}
	}
}

provider "aws" {
	region = "us-east-1" 
}

resource "aws_s3_bucket" "my-test-bucket" {
	bucket 	= "my-tf-test-bucket-102934949"
		
	tags = {
		Name		= "My bucket"
		Environment = "Dev"
		Managedby	= "Terraform"
	}
}

# Cria uma relacao de acesso ao bucket s3
resource "aws_s3_bucket_ownership_controls" "BucketOwnerPreferred" {
  bucket = aws_s3_bucket.my-test-bucket.id # Referencia o bucket
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "acl" {
  depends_on = [aws_s3_bucket_ownership_controls.BucketOwnerPreferred]

  bucket = aws_s3_bucket.my-test-bucket.id
  acl    = "private"
}
