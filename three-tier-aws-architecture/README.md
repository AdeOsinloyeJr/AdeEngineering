# ☁️ AWS 3-Tier Web Application Architecture with Bastion Host

This project demonstrates the deployment of a **highly available 3-tier web application architecture** on AWS, including a Bastion Host for secure SSH access, Application Load Balancer (ALB), Auto Scaling Group (ASG), NAT Gateways, and an RDS database.

---

## 🏗️ Architecture Overview

```
Internet → ALB (Public Subnets) → App EC2s in ASG (Private Subnets) → RDS DB (Private Subnets)
                 ↑
             Bastion Host (Public Subnet)
```
- **Presentation Layer:** ALB
- **Application Layer:** EC2 in private subnets managed by ASG
- **Database Layer:** RDS (MySQL)
- **Security:** Bastion host for SSH, SG rules for controlled access

---

## ✅ Prerequisites
- AWS account
- Key pair for SSH
- Basic Linux command-line knowledge

---

## 🛠️ Steps (With Screenshots)

### 1. Create VPC
![Step 1](images/01.%20VPC%20summary%20page.png)

### 2. Create Subnets (2 Public, 2 Private App, 2 Private DB)
Enable **Auto-Assign Public IPv4** for Public Subnets.
![Step 2](images/02.%20Subnet%20List.png)
![Step 3](images/03.%20Enable%20Auto-Assign%20IPV4%20to%20public%20subnets.png)

### 3. Attach Internet Gateway to VPC
![Step 4](images/04.%20IGW%20attached.png)

### 4. Create NAT Gateways in Each Public Subnet
![Step 5](images/05.%20NAT%20gateways%20page.png)

### 5. Configure Route Tables
- **Public RT:** IGW for internet access
- **App RT:** Route to NAT Gateway for outbound internet
- **DB RT:** Local routes only
![Step 6](images/6.%20Route%20Table%20Summary.png)

---

## 🔐 Security Groups (Summary Table)

| SG Name       | Inbound                               | Outbound                |
|--------------|---------------------------------------|-------------------------|
| SG-Bastion   | SSH (22) from My IP                  | All Traffic            |
| SG-ALB       | HTTP (80) from 0.0.0.0/0            | All Traffic            |
| SG-App       | HTTP (80) from SG-ALB, SSH from Bastion | All Traffic (for updates) |
| SG-DB        | MySQL (3306) from SG-App            | VPC Local              |

![Step 7](images/7.%20SG%20groups.png)

---

### 6. Launch Bastion Host (Public Subnet)
- Generate SSH key on Bastion and copy public key for App Tier user data.
![Step 8](images/9.%20Bastion.png)
![Step 9](images/10.%20Bastion%20ssh-keygen.png)

### 7. Create Launch Template for App Tier
- Include user data with Apache installation + Bastion public key for SSH access.
![Step 10](images/11.%20Launch%20Template%20with%20user%20data%20summary.png)

### 8. Create Target Group for ALB
![Step 11](images/12.%20Target%20Group%20creation.png)

### 9. Create Application Load Balancer (ALB)
- Attach public subnets, SG-ALB, and the target group.
![Step 12](images/13.%20ALB%20Summary.png)

### 10. Create Auto Scaling Group for App Tier
- Attach Launch Template, private subnets, health checks enabled.
![Step 13](images/14.%20ASG%20created.png)
![Step 14](images/15.%20Confirmation%20userdata-launchtemplate%20worked%20as%20intended.png)

### 11. Validate ALB DNS
- ALB should serve the page from private EC2 instances.
![Step 15](images/16.%20ALB%20DNS%20success.png)

### 12. Create RDS Database
- DB in private subnets with SG-DB applied.
![Step 16](images/17.%20DB-SubnetGroups.png)
![Step 17](images/18.%20DB%20created.png)

### 13. Validate DB Connection from App EC2
```bash
mysql -h <RDS-ENDPOINT> -u admin -p
```
![Step 18](images/19.%20Validate%20DB%20connection%20success.png)

---

## ✅ Outcome
- VPC with **public & private subnets**
- Bastion for secure SSH into private tier
- ALB distributing traffic to EC2s in ASG
- NAT gateways enabling app tier outbound traffic
- RDS DB securely connected to app tier
- Scalable & secure 3-tier architecture

---

## 📌 Additional Info (Production Enhancements)
- **NACL:** Extra subnet-level security for compliance (e.g., deny all except ALB/App flow)
- **CloudTrail:** Track API events for governance
- **CloudWatch:** Alarms for ASG CPU metrics and logs
- **Lambda + EventBridge:** Automate user-data or tagging for new ASG instances

---

🔥 **Resource Names Used:**  
- **VPC:** ThreeTier-VPC  
- **Subnets:** Public-1a, Public-1b, App-1a, App-1b, DB-1a, DB-1b  
- **Route Tables:** Public-RT, App-RT, DB-RT  
- **Security Groups:** SG-Bastion, SG-ALB, SG-App, SG-DB  
- **Bastion EC2:** BastionHost  
- **ALB:** ThreeTier-ALB  
- **ASG:** App-ASG  
- **Target Group:** TG-App  
- **RDS:** ThreeTier-DB  
