variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "ap-south-1"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  default     = "ami-0533167fcff018a86"  # Amazon Linux 2023 x86_64 HVM kernel-6.12
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_pair" {
  description = "EC2 Key Pair name for SSH"
  type        = string
}

variable "docker_image" {
  description = "Docker image to deploy on EC2"
  type        = string
}