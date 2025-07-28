# 👋 Hi, I'm Ade!  
### 🚀 Aspiring DevOps & Cloud Engineer

Welcome to my **Cloud Engineering Project Portfolio**! I’m passionate about building and automating cloud infrastructure using **AWS**, **Linux**, and modern **DevOps practices**.  
This repository contains **hands-on, real-world projects** designed to showcase practical skills in cloud architecture, automation, and security.

---

## 👨‍💻 Cloud & Infrastructure Projects

---

### 🔹 [AWS Root Account Monitoring with CloudTrail, SNS & EventBridge](./Root%20Account%20Monitoring%20Project/README.md)
Set up a **real-time monitoring and alerting system** for AWS **root account logins** using **CloudTrail**, **Amazon SNS**, and **EventBridge**. Detect high-privilege activity and send **instant email notifications** for security and compliance.

**Key Features:**
- CloudTrail logging with **S3 + KMS encryption**
- EventBridge rule for root login detection
- SNS email notifications for alerts
- MFA security discussion + best practices

> **Tools:** AWS CloudTrail, EventBridge, SNS, IAM, KMS  
🔹 [View Full Project & Screenshots](./Root%20Account%20Monitoring%20Project/images/)

---

### 🔹 [Three-Tier AWS Architecture Deployment](./three-tier-aws-architecture/README.md)
Build and deploy a **highly available and scalable 3-tier architecture** on AWS featuring **public and private subnets**, **Application Load Balancer (ALB)**, **Auto Scaling Group (ASG)**, and **Amazon RDS**. Includes a **Bastion Host** for secure access and a custom **Launch Template** with user data.

**Key Features:**
- Custom VPC with **public & private subnets** across two AZs
- **Internet Gateway** + **NAT Gateway** for controlled outbound traffic
- **ALB + ASG** for scalability & high availability
- **Amazon RDS** in private subnet for secure DB layer
- Hardened **Security Groups & NACLs**

> **Tools:** AWS VPC, EC2, ALB, ASG, RDS, Route Tables, NAT Gateway, Security Groups, Bash Scripting  
🔹 [View Full Project & Screenshots](./three-tier-aws-architecture/images/)

---

### 🔹 [Deploying Apache and Chrony on EC2](./ec2-apache-chrony-setup_project/Apache-Chrony-EC2-README.md)
Deploy and configure **Apache web server** and **Chrony (NTP)** on **Amazon Linux 2023** to serve a custom web page while ensuring accurate time synchronization across servers.

**Key Features:**
- Apache HTTP server installation and setup
- Custom **index.html** deployment for website hosting
- Configure **Chronyd** for network time protocol (NTP)
- Validate via browser and CLI checks

> **Tools:** AWS EC2, Amazon Linux 2023, systemctl, yum, rpm, Apache, Chrony  
🔹 [View Full Project & Screenshots](./ec2-apache-chrony-setup_project/images/)

---

### 🔹 [Secure File Transfer Between EC2 Instances using SCP](./scp-file-transfer-ec2/)
Demonstrates how to **securely transfer files between two EC2 instances** using `scp`, then host the transferred file via Apache web server.

**Key Features:**
- Provision **two EC2 instances** with SSH key-based authentication
- Use **SCP** for secure file transfer between instances
- Configure **Apache** on destination EC2 to serve the file
- Validate via **browser access**

> **Skills:** EC2 provisioning, SSH, SCP, Apache, Linux file permissions, Bash scripting  
🔹 [View Full Project & Screenshots](./scp-file-transfer-ec2/images/)

---

## 📄 Certifications
- [CompTIA Security+](https://www.credly.com/badges/d4741e33-4b5a-44ff-af58-52c43cdbf076/public_url)

---

## 🤝 Connect With Me
**🔗 [LinkedIn](https://www.linkedin.com/in/adediran-osinloye/)**

---

💡 *Upcoming Projects:* Terraform IaC, Jenkins + Ansible automation, Docker, Kubernetes, and AWS Monitoring solutions.
