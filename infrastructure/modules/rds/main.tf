resource "aws_db_subnet_group" "this" {
  name       = "${var.environment}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "${var.environment}-rds-subnet-group"
    Environment = var.environment
  }
}

resource "aws_db_instance" "this" {
  identifier              = "${var.environment}-mysql"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.instance_class
  allocated_storage       = 20
  storage_type            = "gp2"

  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password

  port                    = 3306
  multi_az                = false         # you can set true later for HA
  publicly_accessible     = false
  skip_final_snapshot     = true

  vpc_security_group_ids  = [var.rds_sg_id]
  db_subnet_group_name    = aws_db_subnet_group.this.name

  backup_retention_period = 0
  deletion_protection     = false

  tags = {
    Name        = "${var.environment}-mysql"
    Environment = var.environment
  }
}
