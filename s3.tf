resource "aws_s3_bucket" "strapi_media" {
  bucket = "${var.project}-media-${random_id.bucket_id.hex}"
  acl    = "private"
  force_destroy = true
  tags = { Name = "${var.project}-s3" }
}

resource "random_id" "bucket_id" { byte_length = 4 }
