resource "aws_ecs_cluster" "this" { name = "${var.project}-cluster" }

resource "aws_lb" "alb" {
  name               = "${var.project}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = values(aws_subnet.public)[*].id
  security_groups    = [aws_security_group.alb_sg.id]
}

resource "aws_lb_target_group" "tg" {
  name     = "${var.project}-tg"
  port     = 1337
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  health_check { path = "/admin || /"; matcher = "200-399"; interval = 30 }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action { type = "forward" target_group_arn = aws_lb_target_group.tg.arn }
}

resource "aws_ecs_task_definition" "strapi" {
  family                   = "${var.project}-task"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name = "strapi"
      image = "${aws_ecr_repository.strapi.repository_url}:latest" # pipeline should push latest
      essential = true
      portMappings = [{ containerPort = 1337, hostPort = 1337, protocol = "tcp" }]
      environment = [
        { name = "DATABASE_HOST", value = aws_db_instance.postgres.address },
        { name = "DATABASE_PORT", value = "5432" },
        { name = "DATABASE_NAME", value = var.db_name },
        { name = "DATABASE_USERNAME", value = var.db_username },
        { name = "DATABASE_PASSWORD", value = var.db_password }
      ]
      mountPoints = []
    }
  ])
}

resource "aws_ecs_service" "strapi" {
  name            = "${var.project}-svc"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.strapi.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets = values(aws_subnet.private)[*].id
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = "strapi"
    container_port   = 1337
  }
  depends_on = [aws_lb_listener.http]
}
