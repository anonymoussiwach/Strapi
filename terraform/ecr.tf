resource "aws_ecr_repository" "strapi" {
  name = "${var.project}-strapi"
  image_tag_mutability = "MUTABLE"
}
