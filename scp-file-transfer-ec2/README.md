# 🚀 EC2‑to‑EC2 Secure File Transfer with **SSH + SCP** (inline walkthrough)

Automate two Amazon Linux 2023 instances via **bash user‑data**, establish key‑based SSH trust, copy a file with `scp`, then serve that file from Apache on the target box.

---

## 🗺️ Architecture

```text
EC2‑A  ──(SSH/SCP 22)──►  EC2‑B  →  /var/www/html/index.html  →  Browser
```
- **EC2‑A** = source (creates key, hosts text file)
- **EC2‑B** = destination (receives file, runs Apache)

---

## 🛠️ Prerequisites
- AWS account & default VPC
- Two security groups allowing inbound **SSH (22)** & **HTTP (80)** between hosts + from your IP
- Key‑pair to login the first time (or Session Manager)

---

## 🏗️  Step‑by‑step (with screenshots)

### 1 ▪️ Launch EC2‑A with bash user‑data
![Step 1](images/01_EC2-A_UserDataScript.png)

### 2 ▪️ Launch EC2‑B with bash user‑data
![Step 2](images/02_EC2-B_UserDataScript.png)

### 3 ▪️ Verify both instances are **running**
![Step 3](images/03_RunningInstances.png)

### 4 ▪️ Generate SSH key‑pair on **EC2‑A**
```bash
ssh-keygen
```
![Step 4](images/04_ssh-keygen-run_EC2A.png)

### 5 ▪️ Display the public key you just created
```bash
cat ~/.ssh/id_rsa.pub
```
![Step 5](images/05_Retrieving_Pub_Key_EC2A.png)

### 6 ▪️ Paste EC2‑A public key into **EC2‑B** `~/.ssh/authorized_keys`
![Step 6](images/06_PastingEC2A_PubKey_inAuthorizedKeysEC2B.png)

### 7 ▪️ Enable password auth in **EC2‑B** `sshd_config` (for demo)
![Step 7](images/07_updating_sshdconfig_passauthentication_usingVI.png)

### 8 ▪️ Restart SSH on **EC2‑B**
```bash
sudo systemctl restart sshd
```
![Step 8](images/08_systemctl_restart_sshd.png)

### 9 ▪️ Test SSH from **EC2‑A → EC2‑B** and create sample files
![Step 9](images/09_SuccesfulSSH-EC2A-EC2B.png)

### 10 ▪️ Confirm files exist on **EC2‑B**
![Step 10](images/10-Confirmation_of_createdfiles_EC2B.png)

### 11 ▪️ Secure‑copy `solution1.txt` from EC2‑A to EC2‑B
```bash
scp /home/ec2-user/solution1.txt ec2-user@44.198.53.64:/home/ec2-user/
```
![Step 11](images/11-SendingFileFrom_EC2A-EC2B-viaSCP.png)

### 12 ▪️ Validate file arrived on **EC2‑B**
![Step 12](images/12-Confirmation_receivedfile_EC2B.png)

### 13 ▪️ Move file to Apache doc‑root as `index.html`
```bash
sudo mv solution1.txt /var/www/html/index.html
```
![Step 13](images/13-Update_IndexHtml-with_Solutiontxt.png)

### 14 ▪️ Browse EC2‑B public IP — page shows transferred text!
![Step 14](images/14-Browser_Confirmation.png)

---

## ✅ Outcome
- **Automated provisioning** with bash‑based user‑data
- **Key‑based SSH** trust established between EC2s
- **SCP** used to transfer file securely
- **Apache** serves transferred content publicly
- Demonstrates practical AWS networking, Linux scripting, and DevOps workflow
