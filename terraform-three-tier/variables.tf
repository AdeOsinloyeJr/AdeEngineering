variable "region" { default = "us-east-1" }
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "key_name" {}
variable "instance_type" { default = "t2.micro" }
variable "db_username" {}
variable "db_password" {}
variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = ""
}
variable "my_ip" {
  description = "73.184.63.221/32"
  type        = string
}
