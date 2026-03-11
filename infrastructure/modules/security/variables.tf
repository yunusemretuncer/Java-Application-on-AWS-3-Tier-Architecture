variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, prod, etc.)"
  type        = string
}
variable "bastion_sg_id" {
  description = "Security group ID of bastion"
  type        = string
}