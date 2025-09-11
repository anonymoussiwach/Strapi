resource "aws_iam_role" "ecs_task_role" {
  name = "${var.project}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume.json
}

data "aws_iam_policy_document" "ecs_task_assume" {
  statement { actions = ["sts:AssumeRole"] principals { type = "Service" identifiers = ["ecs-tasks.amazonaws.com"] } }
}

resource "aws_iam_policy" "ecs_task_policy" {
  name = "${var.project}-ecs-task-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      { Action = ["s3:PutObject","s3:GetObject","s3:DeleteObject","s3:ListBucket"], Effect = "Allow", Resource = [aws_s3_bucket.strapi_media.arn, "${aws_s3_bucket.strapi_media.arn}/*"] },
      { Action = ["secretsmanager:GetSecretValue"], Effect = "Allow", Resource = "*" }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "task_attach" {
  role = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}
