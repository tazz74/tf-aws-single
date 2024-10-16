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

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.7.1"

  name           = "my-ec2-cluster"
  instance_count = 2

  ami                    = "ami-0084a47cc718c111a"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Demo   = "true"
    Environment = "dev"
  }
}
