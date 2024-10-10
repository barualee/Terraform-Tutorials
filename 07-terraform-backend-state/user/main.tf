terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_default_vpc" "default" {}

#configure provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "my_iam_user" {
    name = var.aws_user_name
}