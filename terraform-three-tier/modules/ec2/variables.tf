variable "subnet_id" {}
variable "key_name" {
  type = string
}
variable "instance_type" {}
variable "security_group_ids" { type = list(string) }
variable "image_id" {
  description = "ami-020cba7c55df1f615"
}
