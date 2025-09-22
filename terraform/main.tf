resource "aws_instance" "strapi" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.strapi.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user
              docker run -d -p 80:1337 ${var.docker_image}
              EOF

  tags = {
    Name = "Strapi-Instance"
  }
}