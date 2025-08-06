# VPC Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "Public Subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnets" {
  description = "Private Subnet IDs"
  value       = module.vpc.private_subnet_ids
}

# Bastion Host Outputs
output "bastion_public_ip" {
  description = "Public IP of Bastion Host"
  value       = module.bastion.public_ip
}

# ALB Outputs
output "alb_dns_name" {
  description = "Application Load Balancer DNS Name"
  value       = module.alb.alb_dns_name
}

# ASG Outputs
output "asg_name" {
  description = "Auto Scaling Group Name"
  value       = module.asg.asg_name
}

# RDS Outputs
output "rds_endpoint" {
  description = "RDS Endpoint"
  value       = module.rds.endpoint
}


