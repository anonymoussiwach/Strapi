resource "aws_security_group" "alb_sg" {
  name = "${var.project}-alb-sg"
  vpc_id = aws_vpc.main.id
  description = "Allow HTTP/HTTPS"
  ingress {
    from_port = 80; to_port = 80; protocol = "tcp"; cidr_blocks = var.allowed_cidrs
  }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}

resource "aws_security_group" "ecs_sg" {
  name = "${var.project}-ecs-sg"
  vpc_id = aws_vpc.main.id
  description = "ECS tasks SG"
  ingress {
    from_port = 1337; to_port = 1337; protocol = "tcp"; security_groups = [aws_security_group.alb_sg.id]
  }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}

resource "aws_security_group" "rds_sg" {
  name = "${var.project}-rds-sg"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port = 5432; to_port = 5432; protocol = "tcp"; security_groups = [aws_security_group.ecs_sg.id]
  }
  egress { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}
