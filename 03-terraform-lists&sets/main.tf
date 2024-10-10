variable "names" {
    #default = ["a","b","c"]
    default = ["x","a","b","c"]
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
    #count = length(var.names)
    #name = var.names[count.index]
    #we can do for each with set not with list, it avoids issues with list order
    for_each = toset(var.names)
    name = each.value
}