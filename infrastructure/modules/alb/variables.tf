variable "vpc_id" {
  description = "The VPC ID where the ALB will be deployed"
  type        = string
}

variable "public_subnets_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "environment" {
  description = "Environment name (e.g. dev, prod)"
  type        = string
}

variable "project_name" {
  type        = string
  description = "Project name prefix for resources"
}
variable "alb_sg_id" {
  description = "Security group ID for the ALB"
  type        = string
}

