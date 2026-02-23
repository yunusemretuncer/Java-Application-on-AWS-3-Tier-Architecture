variable "environment" {
  description = "Environment name (dev, prod, etc.)"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for RDS subnet group"
  type        = list(string)
}

variable "rds_sg_id" {
  description = "Security group ID to attach to RDS"
  type        = string
}

variable "db_username" {
  description = "Master DB username"
  type        = string
}

variable "db_password" {
  description = "Master DB password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Initial database name to create"
  type        = string
  default     = "javaapp"
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro" # cheaper than t3.medium for learning
}
