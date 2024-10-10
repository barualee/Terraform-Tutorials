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

#configure ec2 -> HTTP 80, 22, CIDR ["0.0.0.0/0"]
#security group -> 

resource "aws_security_group" "http_server_sg" {
  name = "http_server_sg"
  #vpc_id = "vpc-028538eed195469b3"
  #better way to do is below
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1 #allow everything
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "http_server_sg"
  }
}

resource "aws_instance" "http_server" {
  #ami                    = "ami-066784287e358dad1"
  ami                    = data.aws_ami.aws_linux_2_latest.id
  key_name               = var.aws_key_pair_name
  instance_type          = var.aws_ami_Instance_type
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  subnet_id              = data.aws_subnets.default_subnets.ids[0]

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",                                            #to install http servers
      "sudo service httpd start",                                             # start the server.
      "echo Server at ${self.public_dns} | sudo tee /var/www/html/index.html" #copy index.html file
    ]
  }
}