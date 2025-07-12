
# Deploying Apache and Chrony on EC2

This project demonstrates how to launch and configure a web server on AWS using **Apache** (`httpd`) and enable **Chrony** (`chronyd`) for time synchronization on Amazon Linux 2023.

You’ll walk through:
- Provisioning an EC2 instance
- Installing and verifying Apache web server
- Installing and enabling Chrony time service
- Browser validation that the Apache server is running

---

## 🧰 Tools Used

- AWS EC2
- Amazon Linux 2023
- `yum`, `rpm`, `systemctl`
- Apache (`httpd`)
- Chrony (`chronyd`)

---

## 🖼️ Project Steps (with Screenshots)

1. **EC2 Configuration - Part 1**  
   ![Step 1](images/01_EC2_Configuration1.png)

2. **EC2 Configuration - Part 2**  
   ![Step 2](images/02_EC2_Configuration2.png)

3. **Running EC2 Instance**  
   ![Step 3](images/03_Running_EC2_Instance.png)

4. **System Update (`yum update`)**  
   ![Step 4](images/04_yum_update.png)

5. **Install Apache (`httpd`)**  
   ![Step 5](images/05_httpd_install.png)

6. **Confirm Apache Installation**  
   ![Step 6](images/06_httpd_confirmation.png)

7. **Enable Apache Service**  
   ![Step 7](images/07_httpd_enabled.png)

8. **Install `chrony` Package**  
   ![Step 8](images/08_chrony_install.png)

9. **Confirm Chrony Installation**  
   ![Step 9](images/09_chrony_confirmation.png)

10. **Enable Chrony Service**  
   ![Step 10](images/10_chrony_enabled.png)

11. **Verify Apache via Browser**  
   ![Step 11](images/11_website_working.png)

---

## 📌 Notes

- Ensure inbound rules allow HTTP/SSH traffic in your security group.
- Use a valid key pair to SSH into your EC2 instance.

---

## ✅ Outcome

After completing the steps, Apache will serve a default test page confirming the server is active. Chrony will also be installed and synchronized for accurate system timekeeping.
