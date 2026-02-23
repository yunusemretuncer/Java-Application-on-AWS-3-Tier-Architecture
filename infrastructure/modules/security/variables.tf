variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, prod, etc.)"
  type        = string
}
