terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  #backend "s3" {
  # We'll fill this later when remote state is ready
  #}
}

provider "aws" {
  region  = var.aws_region
  profile = "yunus-devops"
}

# --- VPC Module ---
module "vpc" {
  source = "./modules/vpc"

  environment     = var.environment
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets_ids
  private_subnets = var.private_subnets
}

#---alb---
module "alb" {
  source             = "./modules/alb"
  vpc_id             = module.vpc.vpc_id
  public_subnets_ids = module.vpc.public_subnets_ids
  environment        = var.environment
  project_name       = var.project_name
  alb_sg_id          = module.security.alb_sg_id
}
#---security---

module "security" {
  source      = "./modules/security"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
}
#---asg---
module "asg" {
  source           = "./modules/asg"
  environment      = var.environment
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  key_name         = var.key_name
  app_sg_id        = module.security.app_sg_id
  private_subnets  = module.vpc.private_subnets_ids
  target_group_arn = module.alb.target_group_arn
  desired_capacity = 1
  min_size         = 1
  max_size         = 2
  user_data        = file("user_data.sh")
}

#---bastion---

module "bastion" {
  source           = "./modules/bastion"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = element(module.vpc.public_subnets_ids, 0)
  key_name         = var.key_name
  allowed_ssh_cidr = "95.70.254.56/32"
  subnet_id        = module.vpc.public_subnets_ids[0]
}
#---rds---
module "rds" {
  source = "./modules/rds"

  environment        = var.environment
  private_subnet_ids = module.vpc.private_subnets_ids
  rds_sg_id          = module.security.rds_sg_id

  db_username = var.db_username
  db_password = var.db_password
  db_name     = "javaapp"
}
