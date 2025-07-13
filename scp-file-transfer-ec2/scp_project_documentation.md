# 🚀 EC2-to-EC2 File Transfer Project (Automated via Bash Script + SSH/SCP + Apache)

## ✅ Project Goals

- Automate setup of two EC2 instances using bash scripts via EC2 user data
- Enable secure SSH communication from EC2-A to EC2-B via key-based authentication
- Transfer a file using SCP
- Serve the file via Apache from EC2-B (as homepage)
- Show Linux, scripting, networking, and AWS hands-on proficiency

---

## 🧰 Project Overview

- **EC2-A**: Source EC2 (generates key, sends file)
- **EC2-B**: Destination EC2 (hosts file on Apache web server)

---

## 💪 Step-by-Step Execution Plan

### ✅ Step 1: Launch EC2 Instances with User Data Scripts

#### EC2-A `setup_script_ec2a.sh`
```bash
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

hostnamectl set-hostname EC2-A

echo "This is solution1.txt from EC2-A" > /home/ec2-user/solution1.txt
```

#### EC2-B `setup_script_ec2b.sh`
```bash
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

hostnamectl set-hostname EC2-B
```

**Commands used:**
- `hostnamectl set-hostname <name>`
- `yum update -y`
- `yum install -y httpd`
- `systemctl start|enable httpd`
- `echo "..." > file`

---

### ✅ Step 2: SSH Key Pair Setup (Manual)

**On EC2-A:**
```bash
cd ~/.ssh
ssh-keygen -t rsa
cat id_rsa.pub
```

**On EC2-B:**
```bash
mkdir -p ~/.ssh
nano ~/.ssh/authorized_keys # Paste EC2-A public key
chmod 600 ~/.ssh/authorized_keys

sudo nano /etc/ssh/sshd_config # Change PasswordAuthentication yes
sudo systemctl restart sshd
```

**Commands used:**
- `ssh-keygen -t rsa`
- `nano ~/.ssh/authorized_keys`
- `chmod 600 ~/.ssh/authorized_keys`
- `sudo systemctl restart sshd`

---

### ✅ Step 3: Test SSH Connection

**From EC2-A:**
```bash
ssh ec2-user@<EC2-B IP>
mkdir ~/testfolder
cd ~/testfolder
nano testfile.txt
```

---

### ✅ Step 4: SCP File Transfer

**From EC2-A:**
```bash
scp /home/ec2-user/solution1.txt ec2-user@<EC2-B IP>:/home/ec2-user/
```

**On EC2-B:**
```bash
sudo mv /home/ec2-user/solution1.txt /var/www/html/index.html
```

**Verify:**
Visit `http://<EC2-B Public IP>/` and you should see contents of `solution1.txt`.

---

## 🔹 Optional Enhancements

- Restrict EC2-B's SSH access to EC2-A IP only via security group
- Use `.pem` file method from your local machine instead
- Bash logging and error handling
- Extend the user-data script with additional automated tasks (e.g., timestamp logging)

---

## 📂 Suggested Screenshot List

1. `01_EC2-A_UserDataScript` — EC2-A User Data filled in
2. `02_EC2-B_UserDataScript` — EC2-B User Data filled in
3. `03_RunningInstances` — Screenshot of both EC2s running
4. `04_ssh-keygen-run_EC2A` — Generating key on EC2-A
5. `05_Retrieving_Pub_Key_EC2A` — Retrieving public key from EC2-A
6. `06_PastingEC2A_PubKey_inAuthorizedKeysEC2B` — Pasting key into EC2-B's authorized_keys
7. `07_updating_sshdconfig_passauthentication_usingVI` — Editing sshd_config
8. `08_systemctl_restart_sshd` — Restarting SSH service
9. `09_SuccesfulSSH-EC2A-EC2B` — Successful SSH test
10. `10-Confirmation_of_createdfiles_EC2B` — Verifying directories/files created via SSH
11. `11-SendingFIleFrom_EC2A-EC2B-viaSCP` — SCP in action
12. `12-Confirmation_receivedfile_EC2B` — Confirmation file exists on EC2-B
13. `13-Update_IndexHtml-with_Solutiontxt` — Moved `solution1.txt` to `index.html`
14. `14-Browser_Confirmation` — Live website preview in browser showing updated Apache homepage

---

## ✅ Outcome

- Demonstrated knowledge of AWS EC2 provisioning and automation using bash
- Validated ability to configure SSH key-based access securely
- Used SCP to transfer files between EC2s
- Integrated Apache to host the transferred file on a live web server
- Successfully visualized the results via browser, confirming practical DevOps and cloud infrastructure skills

