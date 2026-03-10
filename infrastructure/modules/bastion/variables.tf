variable "vpc_id" {}
variable "public_subnet_id" {}
variable "key_name" {}
variable "instance_type" {
  default = "t3.micro"
}
variable "allowed_ssh_cidr" {
  description = "Your IP address in CIDR format (e.g. 123.45.67.89/32)"
}
variable "subnet_id" {
  description = "Subnet ID for the bastion host (should be a public subnet)"
  type        = string
}
