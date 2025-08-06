# VPC Module
module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

# Security Groups Module
module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
  my_ip  = var.my_ip
}

# Bastion Host Module
module "bastion" {
  source             = "./modules/ec2"
  subnet_id          = module.vpc.public_subnet_ids[0]
  key_name           = module.keypair.key_name
  instance_type      = var.instance_type
  security_group_ids = [module.security.bastion_sg_id]
  image_id           = var.ami_id
}

# ALB Module
module "alb" {
  source         = "./modules/alb"
  public_subnets = module.vpc.public_subnet_ids
  alb_sg_id      = module.security.alb_sg_id
  vpc_id         = module.vpc.vpc_id
}

# RDS Module
module "rds" {
  source      = "./modules/rds"
  subnet_ids  = slice(module.vpc.private_subnet_ids, 2, 4)
  db_username = var.db_username
  db_password = var.db_password
  sg_id       = module.security.db_sg_id
}

# ASG Module (App Tier)
module "asg" {
  source          = "./modules/asg"
  app_subnet_ids  = slice(module.vpc.private_subnet_ids, 0, 2) # First two private subnets for App tier
  app_sg_id       = module.security.app_sg_id
  key_name        = module.keypair.key_name
  instance_type   = var.instance_type
  tg_arn          = module.alb.tg_arn
  ami_id          = var.ami_id
  asg_name        = "app-tier-ASG"
}

# Key Pair Module
module "keypair" {
  source          = "./modules/keypair"
  key_name        = "LaptopKey"
  public_key_path = "~/.ssh/laptop_key.pub"
}
