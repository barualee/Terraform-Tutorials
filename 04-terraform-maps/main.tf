variable "names" {
  default = {
    lee : { country : "India", department : "ABC" },
    lisa : { country : "Bangi", department : "DEF" },
    man : { country : "Canada", department : "XYZ" }
  }
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
  for_each = var.names
  name     = each.key
  tags = {
    #country: each.value
    country : each.value.country
    department : each.value.department
  }
}