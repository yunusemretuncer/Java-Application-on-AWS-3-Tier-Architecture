# Java-Application-on-AWS-3-Tier-Architecture

This project demonstrates the design, provisioning, and validation of a production-style AWS infrastructure using Terraform, following real-world DevOps and cloud engineering best practices.
The focus of this repository is **infrastructure reliability, security, scalability, and observability**, rather than application complexity.

---

## Architecture Overview

The system is deployed inside a custom VPC and follows a classic layered architecture:

- Public-facing Application Load Balancer (ALB)
- Auto Scaling Group (ASG) of EC2 instances in private subnets
- Nginx acting as reverse proxy
- Backend service running behind the ALB
- Bastion host for secure SSH access
- NAT Gateway for outbound internet access
- Amazon RDS (MySQL) in private subnets
  
---

## Key Features

- Infrastructure as Code using Terraform
- Fully private EC2 instances (no public IPs)
- Secure bastion access pattern
- Auto Scaling Group with rolling instance refresh
- Zero-downtime updates
- ALB health checks and traffic routing
- Modular Terraform design

---

## Technology Stack

- Terraform
- AWS (EC2, ALB, ASG, VPC, NAT Gateway, RDS)
- Nginx

---

## Repository Structure
devops-java-app/
├── infrastructure/    # Terraform modules and environment setup
├── backend/           # Simple backend service (proof of functionality)
├── diagrams/          # Architecture diagrams
├── ROADMAP.md         # Planned improvements
└── README.md

---

## Infrastructure Deployment
 Prerequisites
   - AWS account
   - Terraform >= 1.0
   - AWS CLI configured

 Steps
  - cd infrastructure
  - terraform init
  - terraform plan
  - terraform apply












  
