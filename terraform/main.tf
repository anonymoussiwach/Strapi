resource "aws_instance" "strapi" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.strapi.id]

  user_data = <<-EOF
            #!/bin/bash
            # Update system
            dnf update -y

            # Install Docker
            dnf install -y docker unzip
            systemctl enable docker
            systemctl start docker
            usermod -aG docker ec2-user

            # Install AWS CLI v2
            curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
            unzip awscliv2.zip
            ./aws/install

            # Login to ECR
            aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin 145065858967.dkr.ecr.${var.aws_region}.amazonaws.com

            # Pull and run Strapi container
            docker pull ${var.docker_image}
            docker run -d -p 80:1337 ${var.docker_image}
            EOF

  tags = {
    Name = "Strapi-Instance"
  }
}