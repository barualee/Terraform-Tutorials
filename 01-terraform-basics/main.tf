terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

#configure provider
provider "aws" {
    region = "us-east-1"
}

#plan --> execute
resource "aws_s3_bucket" "my_s3_bucket" {
    bucket = "baruanasa-s3-001-demo"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.my_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

#output
output "my_s3_bucket_versioning" {
    value = aws_s3_bucket.my_s3_bucket.versioning[0].enabled
}

output "my_s3_bucket_complete_details" {
    value = aws_s3_bucket.my_s3_bucket
}
