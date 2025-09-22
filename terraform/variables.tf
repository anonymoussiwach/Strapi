variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "ap-south-1"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  default     = "ami-0533167fcff018a86"  # Amazon Linux 2023
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "key_pair" {
  description = "EC2 Key Pair name for SSH"
  type        = string
}

variable "docker_image" {
  description = "Docker image to deploy on EC2"
  type        = string
  default     = "145065858967.dkr.ecr.ap-south-1.amazonaws.com/strapi-app:latest"
}