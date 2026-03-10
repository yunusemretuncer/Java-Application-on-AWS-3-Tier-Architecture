# AWS 3-Tier Java Application Deployment with Terraform

## Project Overview

This project demonstrates how to deploy a **Java web application on AWS using a 3-tier architecture**.
The infrastructure is created using **Terraform** and includes networking, compute, load balancing, and a database layer.

The goal of this project is to simulate a **basic production-style deployment** where an application is accessible through a load balancer and runs on automatically managed EC2 instances.

---

# Architecture

The system follows a classic **3-tier architecture**:

1. **Presentation Layer**

   * Application Load Balancer (ALB)
   * Routes incoming internet traffic to backend servers.

2. **Application Layer**

   * EC2 instances running:

     * NGINX (reverse proxy)
     * Spring Boot Java application
   * Instances are managed by an **Auto Scaling Group**.

3. **Data Layer**

   * Amazon RDS running MySQL
   * Stores application data.

---

# Architecture Diagram

```
           Internet
               │
               ▼
      Application Load Balancer
               │
               ▼
        Auto Scaling Group
               │
        ┌───────────────┐
        │   EC2 Instance │
        │                │
        │  NGINX Proxy   │
        │       │        │
        │  Java App      │
        └───────────────┘
               │
               ▼
           Amazon RDS
             MySQL
```

---

# Technologies Used

* **AWS**

  * VPC
  * EC2
  * Auto Scaling Group
  * Application Load Balancer
  * RDS (MySQL)
  * S3
  * IAM

* **Infrastructure as Code**

  * Terraform

* **Application**

  * Java
  * Spring Boot
  * NGINX

---

# Infrastructure Components

### VPC

* Custom Virtual Private Cloud
* Public and private subnets
* Internet Gateway
* Route tables

### Bastion Host

* Allows secure SSH access to private EC2 instances.

### Application Load Balancer

* Public entry point for the application
* Performs health checks

### Auto Scaling Group

* Automatically manages EC2 instances
* Ensures high availability

### EC2 Instances

* Run NGINX and the Java application
* Download application artifact from S3 during startup

### RDS Database

* MySQL database used by the application.

---

# Deployment Steps

1. Clone the repository

```
git clone https://github.com/yourusername/devops-java-app.git
cd devops-java-app/infrastructure
```

2. Initialize Terraform

```
terraform init
```

3. Plan the infrastructure

```
terraform plan
```

4. Deploy the infrastructure

```
terraform apply
```

5. After deployment, copy the **Load Balancer DNS name** and open it in a browser.

Example:

```
http://your-load-balancer-dns
```

---

# Features

* Infrastructure fully managed with **Terraform**
* **Auto Scaling** for high availability
* **Load balancing** for traffic distribution
* **Reverse proxy using NGINX**
* **Automated application startup using user-data scripts**
* Secure architecture using **private subnets**

---

# Learning Outcomes

This project helped me understand:

* AWS cloud infrastructure design
* Infrastructure as Code with Terraform
* Load balancing and auto scaling
* Deploying Java applications in the cloud
* Networking concepts in AWS (VPC, subnets, routing)

---

# Future Improvements

Possible improvements for this project:

* Add **CI/CD pipeline** for automated deployments
* Add **HTTPS with SSL certificates**
* Use **Docker containers**
* Monitor infrastructure using **CloudWatch**

---

# Author

Yunus
DevOps / Cloud Engineering Student










  
