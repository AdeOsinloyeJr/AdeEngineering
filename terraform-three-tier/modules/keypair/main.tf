resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = file("${path.module}/../../keys/LaptopKey.pub")
}
