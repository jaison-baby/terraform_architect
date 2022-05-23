resource "aws_db_instance" "default" {
  identifier           = var.identifier
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name                 = var.name
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  vpc_security_group_ids = [var.security-groupid]
  db_subnet_group_name = aws_db_subnet_group.rds-subnet-group.name
  publicly_accessible  = true
}


resource "aws_db_subnet_group" "rds-subnet-group" {
  name        = "rds-subnet-group"
  description = "Terraform example RDS subnet group"
  subnet_ids  = [var.subnetid,var.subnetid2]
}

