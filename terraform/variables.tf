variable "aws_region" {
  type    = string
  default = "ap-south-1" # change if you want
}

variable "project" {
  type    = string
  default = "strapi-demo"
}

variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "public_subnets" { type = list(string) default = ["10.0.1.0/24","10.0.2.0/24"] }
variable "private_subnets" { type = list(string) default = ["10.0.11.0/24","10.0.12.0/24"] }

variable "db_username" { type = string default = "strapi_user" }
variable "db_password" { type = string }
variable "db_name" { type = string default = "strapi_db" }

variable "allowed_cidrs" { type = list(string) default = ["0.0.0.0/0"] }
