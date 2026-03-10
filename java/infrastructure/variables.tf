variable "aws_region" {}
variable "vpc_cidr" {}
variable "public_subnets_ids" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "project_name" {
  description = "Project name prefix for resources"
  type        = string
  default     = "devops-java-app"
}


variable "ami_id" {
  description = "Optional AMI ID. If empty, modules will use latest Amazon Linux 2."
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "key_name" {
  description = "SSH key name"
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  default     = "dev"
}
variable "db_username" {
  description = "DB master username"
  type        = string
}

variable "db_password" {
  description = "DB master password"
  type        = string
  sensitive   = true
}
