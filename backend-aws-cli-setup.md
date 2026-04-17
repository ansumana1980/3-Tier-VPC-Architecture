````md
## Backend AWS CLI Setup for Terraform State

This document creates the backend resources for the **ansu-3-tier-vpc** Terraform project.

---

## 1. Create the S3 bucket

```bash
aws s3api create-bucket \
  --bucket ansu-3-tier-vpc-terraform-state \
  --region us-east-1
````

---

## 2. Add bucket tags

```bash
aws s3api put-bucket-tagging \
  --bucket ansu-3-tier-vpc-terraform-state \
  --tagging 'TagSet=[
    {Key=Name,Value=terraform-state-bucket},
    {Key=Environment,Value=dev},
    {Key=Project,Value=ansu-3-tier-vpc},
    {Key=Architecture,Value=3-tier},
    {Key=ManagedBy,Value=manual}
  ]'
```

---

## 3. Enable versioning

```bash
aws s3api put-bucket-versioning \
  --bucket ansu-3-tier-vpc-terraform-state \
  --versioning-configuration Status=Enabled
```

---

## 4. Enable encryption

```bash
aws s3api put-bucket-encryption \
  --bucket ansu-3-tier-vpc-terraform-state \
  --server-side-encryption-configuration '{
    "Rules": [{
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "AES256"
      }
    }]
  }'
```

---

## 5. Block public access

```bash
aws s3api put-public-access-block \
  --bucket ansu-3-tier-vpc-terraform-state \
  --public-access-block-configuration \
  BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true
```

---

## 6. Create DynamoDB table for state locking

```bash
aws dynamodb create-table \
  --table-name terraform-ansu-3-tier-vpc-locks \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1
```

---

## Why this is good practice

You are separating responsibilities:

| Responsibility             | Tool      |
| -------------------------- | --------- |
| Backend infrastructure     | AWS CLI   |
| Application infrastructure | Terraform |

This is a common and practical setup.

---

## Important rule

Once created:

**Do not manage this S3 bucket or DynamoDB lock table inside the same Terraform project that uses them as the backend.**

Create them first, then reference them from `backend.tf`.

---

## Interview-ready explanation

If asked, “How do you manage Terraform state securely?”

You can say:

> I create a dedicated S3 bucket for Terraform state with versioning, encryption, and public access blocking, and I use DynamoDB for state locking. Then I configure the Terraform project to use that backend rather than managing the backend resources inside the same configuration.

---

## Next step

After creating the backend resources, run:

```bash
terraform init -reconfigure
terraform plan
```

````

Also update your `backend.tf` to match exactly:

```hcl
terraform {
  backend "s3" {
    bucket         = "ansu-3-tier-vpc-terraform-state"
    key            = "ansu-3-tier-vpc/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-ansu-3-tier-vpc-locks"
    # profile = "terraform-user"
  }
}
````

One small note: Terraform warned that `dynamodb_table` is deprecated in your installed version. It may still work, but if `terraform init` later complains, tell me your Terraform version and I’ll give you the updated backend syntax.
