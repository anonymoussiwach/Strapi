resource "aws_instance" "strapi" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair
  security_groups = [aws_security_group.strapi.name]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              docker run -d -p 80:1337 ${var.docker_image}
              EOF
}