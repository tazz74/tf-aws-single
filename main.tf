oterraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.71.0"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
}

resource "aws_instance" "Demo_server" {
  ami           = "ami-0084a47cc718c111a"
  instance_type = "t2.small"

  tags = {
    Name = "Demo-Server-Instance"
  }
}
