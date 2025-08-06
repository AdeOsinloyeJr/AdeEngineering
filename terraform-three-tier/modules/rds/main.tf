resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "three-tier-db-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "this" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [var.sg_id]
  skip_final_snapshot  = true
  tags = { Name = "ThreeTier-DB" }
}
