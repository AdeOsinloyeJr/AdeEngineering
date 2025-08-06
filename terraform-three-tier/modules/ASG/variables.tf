variable "app_subnet_ids" { type = list(string) }

variable "key_name" {
  type = string
}

variable "instance_type" {}
variable "tg_arn" {}
variable "ami_id" {
  description = "ami-020cba7c55df1f615"
}
variable "app_sg_id" {
  description = "sg-012f10895bb0688da"
  type        = string
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
  default     = "app-tier-asg"
}


