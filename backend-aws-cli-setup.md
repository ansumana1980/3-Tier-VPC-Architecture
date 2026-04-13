<<<<<<< HEAD
## 🔥 Full AWS CLI commands

### 1. Create S3 bucket

```bash
aws s3api create-bucket \
  --bucket 3-tier-vpc-architecture-terraform-state \
  --region us-east-1
```

---
### 2. Add tags

```bash
aws s3api put-bucket-tagging \
  --bucket 3-tier-vpc-architecture-terraform-state \
=======

## 🔥 Full AWS CLI commands (production-style)

### 1. Create S3 bucket

```bash
aws s3api create-bucket \
  --bucket 2-tier-vpc-architecture-terraform-state \
  --region us-east-1
```

---
### 2. Add tags

```bash
aws s3api put-bucket-tagging \
  --bucket 2-tier-vpc-architecture-terraform-state \
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
  --tagging 'TagSet=[
    {Key=Name,Value=terraform-state-bucket},
    {Key=Environment,Value=dev},
    {Key=Project,Value=2-tier-vpc},
    {Key=ManagedBy,Value=manual}
  ]'
```

### 3. Enable versioning

```bash
aws s3api put-bucket-versioning \
<<<<<<< HEAD
  --bucket 3-tier-vpc-architecture-terraform-state \
=======
  --bucket 2-tier-vpc-architecture-terraform-state \
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
  --versioning-configuration Status=Enabled
```

---

### 4. Enable encryption

```bash
aws s3api put-bucket-encryption \
<<<<<<< HEAD
  --bucket 3-tier-vpc-architecture-terraform-state \
=======
  --bucket 2-tier-vpc-architecture-terraform-state \
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
  --server-side-encryption-configuration '{
    "Rules": [{
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "AES256"
      }
    }]
  }'
```

---

### 5. Block public access

```bash
aws s3api put-public-access-block \
<<<<<<< HEAD
  --bucket 3-tier-vpc-architecture-terraform-state \
=======
  --bucket 2-tier-vpc-architecture-terraform-state \
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
  --public-access-block-configuration \
  BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true
```

---

### 6. Create DynamoDB table (locking)

```bash
aws dynamodb create-table \
<<<<<<< HEAD
  --table-name terraform-3-tier-vpc-architecture-locks \
=======
  --table-name terraform-2-tier-vpc-architecture-locks \
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
```

---

<<<<<<< HEAD
=======
## 🧠 Why this is GOOD practice

You are separating concerns:

| Responsibility           | Tool      |
| ------------------------ | --------- |
| Backend infra            | AWS CLI   |
| App infra (VPC, subnets) | Terraform |

👉 This is very common in real environments
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071

---

## 🚨 Important rule

Once created:

👉 **DO NOT manage that S3 bucket in your VPC Terraform project**

<<<<<<< HEAD

=======
That’s what caused your earlier error.
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071

---

## 💬 Interview-ready explanation

If asked:

> “How do you manage Terraform state securely?”

You can say:

> “I provision an S3 bucket with versioning, encryption, and public access blocking using AWS CLI, and configure DynamoDB for state locking. My Terraform projects then use that backend but do not manage it directly.”

🔥 That’s a strong answer.

---
<<<<<<< HEAD
=======

## 🚀 Next step

Now that your backend is correct:

```bash
terraform init -reconfigure
terraform plan
```

---

If you want, next I can:
👉 Review your **terraform plan output before apply (highly recommended)**
👉 Or help you add **EC2 + ALB to make this a full 2-tier app architecture**
>>>>>>> f4440188ab6c253222ef11af85a5fdec83784071
