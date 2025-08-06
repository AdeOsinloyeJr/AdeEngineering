terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-641647330206"
    key            = "3tier/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
