# Fecha a versão do terraform e do provider
terraform {
  required_version = "1.3.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.15.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "my-test-bucket" {
  # bucket = "my-tf-test-bucket-102934949"

  # Exemplo de como o nome criar um bucket dinâmico e com random
  bucket = "${random_pet.bucket.id}-${var.environment}"

  # carrega as tag comuns do arquivo locals.tf
  tags = local.common_tags
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

# Cria um objeto no bucket s3 como exemplo
resource "aws_s3_object" "this" {
  bucket = aws_s3_bucket.my-test-bucket.bucket
  key    = "config/${local.ip_filepath}"
  source = local.ip_filepath
  etag   = filemd5(local.ip_filepath)
  content_type = "application/json"
}

