terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.72.0"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
}

resource "aws_instance" "Web-server" {
    ami = "ami-0084a47cc718c111a"
    instance_type = "t2.micro"

    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.default.id]
    associate_public_ip_address = true

    user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install httpd -y
    echo "<html><h1>webpage 1(I've been provisioned using HasiCorp Terraform!)</h1></html>" > /var/www/html/index.html
    service httpd start
    chkconfig httpd on
    EOF
    tags = {
      Name = "Web_server"
    }
}

