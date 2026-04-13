---

# 3-Tier AWS VPC Architecture with Terraform

This project provisions a **3-tier AWS VPC architecture** using Terraform. It creates a reusable and modular network foundation with **public, application, and data subnets across two Availability Zones**, along with the routing components needed for internet access and secure outbound connectivity.

---

## Project Structure

```bash
3-Tier-VPC-Architecture/
├── .terraform/
├── modules/
│   └── vpc/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── .gitignore
├── .terraform.lock.hcl
├── backend-aws-cli-setup.md
├── backend.tf
├── main.tf
├── outputs.tf
├── OVERVIEW.md
├── providers.tf
├── README.md
├── terraform.tfvars
├── terraform.tfvars.example
├── tplan
└── variables.tf
```

---

## Structure explanation

* **modules/vpc/**
  Contains the reusable VPC module that creates the VPC, subnets, route tables, Internet Gateway, NAT Gateway, and subnet associations.

* **backend.tf**
  Configures the remote Terraform backend using S3 and DynamoDB.

* **main.tf**
  Calls the VPC module and passes all required variables from the root module.

* **variables.tf**
  Declares input variables used by the root module.

* **terraform.tfvars**
  Stores actual environment-specific values for this deployment.

* **terraform.tfvars.example**
  Template file showing the expected input format for reuse.

* **outputs.tf**
  Exposes important resource IDs and values after deployment.

* **providers.tf**
  Defines the Terraform and AWS provider configuration.

* **OVERVIEW.md / README.md**
  Project documentation and architecture explanation.

---

## What “3-tier” means

This architecture is divided into three layers:

1. **Public tier (Web layer)**
2. **Application tier**
3. **Data tier**

This design improves:

* security
* scalability
* separation of concerns
* high availability

---

## 1. The VPC

At the center of the design is the **VPC (Virtual Private Cloud)**.

The VPC:

* has its own CIDR block
* contains all subnets (public, app, data)
* includes route tables
* is attached to an Internet Gateway

Think of the VPC as your **private AWS network boundary**.

---

## 2. Availability Zones

This architecture uses two explicit Availability Zones:

* `availability_zone_1`
* `availability_zone_2`

Example:

* `us-east-1a`
* `us-east-1b`

Benefits:

* high availability
* fault tolerance
* resilience

---

## 3. Public Tier (Web Layer)

You created two public subnets:

* `public_subnet_az1`
* `public_subnet_az2`

These are public because:

* associated with a **public route table**
* route `0.0.0.0/0 → Internet Gateway`
* `map_public_ip_on_launch = true`

### Typical resources

* Application Load Balancer (ALB)
* NAT Gateway
* Bastion host

This is your **internet-facing layer**.

---

## 4. Internet Gateway

The Internet Gateway:

* allows inbound internet traffic
* allows outbound internet traffic
* is attached to the VPC

Without it → no internet access.

---

## 5. Public Route Table

Routes:

* `0.0.0.0/0 → Internet Gateway`

Associated with both public subnets.

### Result

Public resources are reachable from the internet.

---

## 6. Application Tier (Private App Subnets)

You created:

* `private_app_subnet_az1`
* `private_app_subnet_az2`

These are private because:

* no public IP assignment
* no direct route to Internet Gateway

### Typical resources

* EC2 app servers
* ECS services
* APIs
* backend services

These handle business logic.

---

## 7. Data Tier (Private Data Subnets)

You created:

* `private_data_subnet_az1`
* `private_data_subnet_az2`

These are **even more restricted**.

### Typical resources

* RDS databases
* Redis / ElastiCache
* internal storage services

These should **never be internet-facing**.

---

## 8. NAT Gateway

The NAT Gateway is placed in a public subnet.

It allows:

* outbound internet access from private subnets
* software updates and external API calls

But:

* blocks inbound internet traffic

---

## 9. Private Route Tables

Private subnets use:

* `0.0.0.0/0 → NAT Gateway`

### Result

* App + Data layers can reach internet outbound
* No inbound internet access

---

## 10. Traffic Flow

### Inbound flow

Internet
→ Internet Gateway
→ Public subnet (ALB)
→ App subnet
→ Data subnet

---

### Outbound flow

App/Data subnet
→ NAT Gateway
→ Internet

---

## 11. Why this design is strong

### Security

* Database tier is fully isolated
* Application tier is protected
* Only public tier is exposed

---

### High Availability

* All tiers span **2 Availability Zones**

---

### Scalability

You can easily add:

* ALB → Public tier
* Auto Scaling → App tier
* RDS Multi-AZ → Data tier

---

### Reusability

* Built as a Terraform module
* Easily reused across environments

---

## 12. Terraform Design

### Root module

Responsible for:

* provider config
* backend config
* variable passing
* module call
* outputs

---

### VPC module

Responsible for:

* VPC
* subnets (all tiers)
* IGW
* NAT Gateway
* route tables
* associations

---

## 13. Tagging Strategy

Centralized tagging:

```hcl
common_tags = {
  Project      = "ansu-3-tier-vpc"
  Environment  = "dev"
  ManagedBy    = "Terraform"
  Owner        = "Ansu"
  Architecture = "3-tier"
}
```

Example naming:

```hcl
Name = "ansu-3-tier-vpc-dev-private-data-subnet-az1"
```

---

## 14. Example Input Values

```hcl
region       = "us-east-1"
project_name = "ansu-3-tier-vpc"
environment  = "dev"

vpc_cidr_block = "10.0.0.0/16"

public_subnet_az1_cidr       = "10.0.1.0/24"
public_subnet_az2_cidr       = "10.0.2.0/24"

private_app_subnet_az1_cidr  = "10.0.3.0/24"
private_app_subnet_az2_cidr  = "10.0.4.0/24"

private_data_subnet_az1_cidr = "10.0.5.0/24"
private_data_subnet_az2_cidr = "10.0.6.0/24"

availability_zone_1 = "us-east-1a"
availability_zone_2 = "us-east-1b"

enable_dns_support   = true
enable_dns_hostnames = true

map_public_ip_on_launch         = true
private_map_public_ip_on_launch = false
```

---

## 15. Commands

```bash
terraform init -reconfigure
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
terraform destroy
```

---

## 16. Interview Explanation (🔥)

> I built a modular 3-tier VPC architecture in AWS using Terraform. The design separates public, application, and data layers across multiple availability zones for high availability and security. I implemented an Internet Gateway for public access, a NAT Gateway for outbound private subnet connectivity, and structured the project using reusable modules and centralized tagging. The architecture is scalable and ready for load balancing, compute, and database integrations.

---

## 17. Future Enhancements

* Application Load Balancer (ALB)
* EC2 / ECS services
* RDS database layer
* Security groups module
* Monitoring & logging
* CI/CD pipelines

---

