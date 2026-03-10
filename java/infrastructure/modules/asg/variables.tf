variable "environment" {}
variable "ami_id" {
  description = "Optional AMI ID. If empty, latest Amazon Linux 2 AMI is used."
  type        = string
  default     = ""
}
variable "instance_type" {}
variable "key_name" {}
variable "app_sg_id" {}
variable "private_subnets" {
  type = list(string)
}
variable "target_group_arn" {}
variable "desired_capacity" {
  default = 1
}
variable "min_size" {
  default = 1
}
variable "max_size" {
  default = 2
}
variable "user_data" {
  description = "User data script for EC2 initialization"
  type        = string
}
