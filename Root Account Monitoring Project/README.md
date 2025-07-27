
# 🔐 AWS Root Account Monitoring with CloudTrail, SNS, and EventBridge

## ✅ Objective
Set up a real-time monitoring system to **detect AWS root account logins** and send **instant email alerts** using AWS-native services:  
**CloudTrail**, **Amazon SNS**, and **EventBridge**.

---

## ✅ Why This Matters
Even though AWS now enforces **MFA for root users**, monitoring root activity is still critical because:
- Root has **unrestricted access** to all resources, including billing and security settings.
- MFA reduces risk but does not eliminate threats (insider misuse, compromised sessions, phishing).
- Compliance frameworks (SOC 2, HIPAA) require **audit trails** and **alerting for privileged activity**.

**This project demonstrates proactive security detection using AWS-native tools.**

---

## ✅ Tools Used
- **AWS Management Console**
- **AWS CloudTrail**
- **Amazon SNS**
- **Amazon EventBridge**
- **KMS** (for encryption)

---

## ✅ Architecture Overview
1. **CloudTrail** logs root activity.
2. **EventBridge** detects root login events.
3. **SNS** sends an **email alert**.

---

## ✅ Steps

---

### **Step 1: Simulate Root Account Activity**
Sign in as the **AWS root user** to generate an event for CloudTrail to log.  
We accessed the **Billing Dashboard** to simulate a high-privilege action.

> **Note:** This was a **read-only view** for demonstration purposes. In production, root usage should be minimized.

![Simulate Root Account Activity](images/1.%20Simulate%20Root%20Account%20Activity.png)

![View Private Billing Info](images/2.%20View%20Private%20Billing%20Info.png)

---

### **Step 2: Remove MFA from Root User (Simulation Only)**
To simulate an environment where root security is weakened, MFA was removed temporarily.

> **⚠ Security Note:** In real-world setups, never disable MFA. This is purely for lab testing.

![Remove MFA from Root User](images/3.%20Remove%20MFA%20from%20Root%20User.png)

---

### **Step 3: Enable CloudTrail with KMS Encryption**
- Create a new trail named `RootManagement-events`.
- Store logs in a new S3 bucket.
- Enable **SSE-KMS encryption** with a KMS alias: `alias/root-log-encryption`.
- Enable **SNS notification delivery** and select/create SNS topic: `RootManagement_Topic`.

![CloudTrail Creation](images/4.%20Cloud%20Trail%20Creation.png)

---

### **Step 4: Create SNS Topic & Email Subscription**
- Go to **SNS → Topics → Create Topic** (Standard).
- Name: `RootManagement_Topic`.
- Create a subscription with your email address.
- You will receive a confirmation email.

![SNS Subscription](images/5.%20Subscription%20For%20Topic%20Created.png)

---

### **Step 5: Create EventBridge Rule to Detect Root Login**
1. Go to **Amazon EventBridge → Rules → Create Rule**.
2. Name: `RootLoginAlert`.
3. Select **Rule with an event pattern**.
4. Use this **JSON pattern**:

```json
{
  "detail-type": ["AWS Console Sign In via CloudTrail"],
  "detail": {
    "userIdentity": {
      "type": ["Root"]
    }
  }
}
```

5. Set target as **SNS topic → RootManagement_Topic**.
6. Allow EventBridge to create an IAM role for SNS invocation.

![EventBridge Rule Detail](images/6a.%20Creation%20of%20EventBridge%20Rule.png)

![Rule Event Pattern](images/6b.%20Rule%20configuration.png)

![SNS Target Selection](images/6c.%20SNS%20Target%20Selection.png)

---

### **Step 6: Confirm SNS Subscription**
Before testing, confirm your SNS subscription from your email inbox.

![SNS Email Confirmation](images/7.%20Confirm%20Subscription%20via%20email.png)

---

### **Step 7: Test the Setup**
- Log out and log back in as root user.
- Within a minute, you should receive an SNS email alert.

![SNS Alert Working](images/8.%20SNS%20alert%20working.png)

---

## ✅ Security Notes
- **Blur these in screenshots:**
  - AWS Account ID
  - S3 Bucket names
  - KMS Key IDs/ARN
  - IP addresses
  - MFA device identifiers
  - OAuth/session URLs
- **Safe to show:**
  - Trail name
  - SNS topic name
  - KMS alias
  - EventBridge rule name

---

## ✅ Cleanup (Avoid Charges)
- Delete **CloudTrail trail** and associated **S3 bucket**.
- Delete **SNS topic** and subscription.
- Delete **EventBridge rule**.
- Schedule deletion for the **KMS key** (AWS requires 7+ days).

---

## ✅ Key Learnings
- Combining **CloudTrail + EventBridge + SNS** creates a strong security alerting system.
- MFA is a **preventive control**; monitoring is a **detective control**.
- Minimal root usage should always be enforced.

---

## ✅ Next Steps
Enhance detection with:
- **CloudWatch Metrics + Alarms** for login failures.
- **AWS Lambda** for automated remediation (e.g., disable root sessions).
