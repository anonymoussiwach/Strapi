Strapi CMS Deployment with Terraform on AWS

 Overview

This project demonstrates how to design Infrastructure as Code (IaC) for deploying Strapi — a headless CMS — on AWS using Terraform.

Due to limited time, I focused on writing all the Terraform configurations needed for a production-like deployment. These files can be applied with Terraform to fully provision the infrastructure.

⸻

 Architecture

The setup follows a modular AWS architecture:
	•	VPC & Networking → Custom VPC with public/private subnets, internet gateway, NAT gateway, and route tables.
	•	Security Groups → Least-privilege rules for ALB, ECS tasks, and RDS.
	•	ECS Fargate → Runs the Strapi container as a service behind an Application Load Balancer.
	•	RDS (PostgreSQL) → Managed database for Strapi.
	•	S3 Bucket → Storage for media uploads.
	•	ECR → Registry for storing the Strapi Docker image.
	•	IAM Roles & Policies → Permissions for ECS tasks to pull images and access S3.

⸻

 Repo Structure
	•	provider.tf → AWS provider setup.
	•	vpc.tf → Networking resources (VPC, subnets, IGW, NAT).
	•	security_groups.tf → Security group rules.
	•	rds.tf → PostgreSQL database instance.
	•	s3.tf → S3 bucket for Strapi media.
	•	ecr.tf → Elastic Container Registry for Docker image.
	•	ecs.tf → ECS cluster, task definition, service, and ALB.
	•	iam.tf → IAM roles and policies.
	•	outputs.tf → Exposed values (ALB DNS, DB endpoint, etc.).

⸻

 Deployment Steps

These steps are not executed here due to time constraints, but the written code is deploy-ready.

	1.	Clone repo

git clone https://github.com/anonymoussiwach/Strapi.git
cd strapi-terraform-aws


	2.	Initialize Terraform

terraform init


	3.	Preview infrastructure

terraform plan


	4.	Deploy (would take ~15–20 minutes on AWS)

terraform apply


	5.	Build and push Strapi Docker image to ECR.
	6.	ECS service pulls the image and runs behind ALB → Access Strapi at ALB DNS.

⸻

� Video Explanation

Since I could not provision AWS resources in the given deadline, I created a short video walkthrough of:
	•	Repo structure
	•	Explanation of each Terraform file
	•	My thought process for deployment

[Video Link Here]

⸻

 Future Improvements
	•	Add HTTPS with AWS ACM (TLS certificate).
	•	Use AWS Secrets Manager for DB credentials.
	•	Automate Docker build + ECR push with GitHub Actions.
	•	Add monitoring via CloudWatch and logging for Strapi tasks.

⸻

This repo demonstrates my ability to break down a deployment into IaC components, write clean Terraform code, and design a scalable cloud architecture.
