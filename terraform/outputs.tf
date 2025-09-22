output "ec2_public_ip" {
  description = "Public IP of Strapi EC2 instance"
  value       = aws_instance.strapi.public_ip
}