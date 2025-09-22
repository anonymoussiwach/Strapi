output "ec2_public_ip" {
  description = "Public IP of the EC2 instance running Strapi"
  value       = aws_instance.strapi.public_ip
}