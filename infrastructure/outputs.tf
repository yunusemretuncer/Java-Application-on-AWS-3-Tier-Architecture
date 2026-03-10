output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# --- Networking ---
output "public_subnets_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnets_ids
}

output "private_subnets_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnets_ids
}

# Optional: if your vpc module outputs these (add only if they exist)
# output "nat_gateway_id" {
#   description = "NAT Gateway ID"
#   value       = module.vpc.nat_gateway_id
# }

# --- ALB ---
output "alb_dns_name" {
  description = "Application Load Balancer DNS"
  value       = module.alb.alb_dns_name
}

output "target_group_arn" {
  description = "Target Group ARN"
  value       = module.alb.target_group_arn
}

# --- Security Groups ---
output "alb_sg_id" {
  description = "ALB Security Group ID"
  value       = module.security.alb_sg_id
}

output "app_sg_id" {
  description = "App (ASG instances) Security Group ID"
  value       = module.security.app_sg_id
}

output "bastion_sg_id" {
  description = "Bastion Security Group ID"
  value       = module.bastion.bastion_sg_id
}

output "rds_sg_id" {
  description = "RDS Security Group ID"
  value       = module.security.rds_sg_id
}

# --- Bastion ---
output "bastion_public_ip" {
  description = "Bastion Public IP"
  value       = module.bastion.public_ip
}

output "bastion_instance_id" {
  description = "Bastion instance id"
  value       = module.bastion.instance_id
}

# --- Auto Scaling ---
output "asg_name" {
  description = "Auto Scaling Group name"
  value       = module.asg.asg_name
}

output "launch_template_id" {
  description = "Launch Template ID"
  value       = module.asg.launch_template_id
}

# --- Database ---
output "rds_endpoint" {
  description = "RDS endpoint"
  value       = module.rds.endpoint
}

output "rds_db_name" {
  description = "RDS DB name"
  value       = module.rds.db_name
}
