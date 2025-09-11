resource "aws_db_subnet_group" "rds_subnets" {
  name = "${var.project}-rds-subnets"
  subnet_ids = values(aws_subnet.private)[*].id
}

resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "13.9"
  instance_class       = "db.t3.micro"
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.rds_subnets.name
  publicly_accessible  = false
  tags = { Name = "${var.project}-rds" }
}
