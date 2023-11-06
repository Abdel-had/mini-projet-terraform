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

module "sgmodule" {
  source = "../modules/sgmodule"
  sg_name = "app-sg"
}

module "ec2module" {
  source = "../modules/ec2module"
  instancetype = "t2.micro"
  aws_common_tag = {
    Name = "ec2-dev-abdelhad"
  }
  security_group_name = "app-sg"
}

module "eipmodule" {
  source = "../modules/eipmodule"
  instance_id = module.ec2module.ec2_id
}

module "ebsmodule" {
  source = "../modules/ebsmodule"
  ebs_size = 10
}

