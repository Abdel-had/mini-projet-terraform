provider "aws" {
  region     = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-backend-abdelhad"
    key    = "abdelhad-dev.tfstate"
    region     = "us-east-1"
  }
}

module "security_group" {
  source = "../modules/security_group"
  sg_name = "app-sg"
}

module "ec2_instance" {
  source = "../modules/ec2_instance"
  instancetype = "t2.micro"
  aws_common_tag = {
    Name = "ec2-dev-abdelhad"
  }
  security_group_name = "app-sg"
}

module "public_ip" {
  source = "../modules/public_ip"
  instance_id = module.ec2_instance.ec2_id
}

module "ebs_volume" {
  source = "../modules/ebs_volume"
  ebs_size = 10
}

