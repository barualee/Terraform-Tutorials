variable "iam_username_prefix" {
    type = string #any, number, bool, list, map, set, object, tuple
    default = "my_iam_user"
}

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

resource "aws_iam_user" "my_iam_users" {
    count = 2
    name = "${var.iam_username_prefix}_${count.index}"
}