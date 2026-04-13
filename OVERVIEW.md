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

The VPC is your private network inside AWS. In this project, it:

* has its own CIDR block
* contains all subnets (public, application, and data)
* includes route tables
* is attached to an Internet Gateway

Think of the VPC as the main network boundary that contains everything else.

---

## 2. Availability Zones

This architecture uses two explicit Availability Zones:

* `availability_zone_1`
* `availability_zone_2`

In your configuration:

* `us-east-1a`
* `us-east-1b`

Using two Availability Zones improves:

* resilience
* fault tolerance
* high availability

If one Availability Zone has an issue, the other can continue serving traffic.

---

## 3. Public Tier (Web Layer)

You created two public subnets:

* `public_subnet_az1`
* `public_subnet_az2`

These subnets are public because:

* they are associated with the **public route table**
* the route table sends `0.0.0.0/0` traffic to the **Internet Gateway**
* `map_public_ip_on_launch = true`

### Typical resources in the public tier

* Application Load Balancers (ALB)
* NAT Gateways
* Bastion hosts

This is your **internet-facing layer**.

---

## 4. Internet Gateway

You created an **Internet Gateway** and attached it to the VPC.

The Internet Gateway allows:

* inbound internet traffic to reach public resources
* outbound internet traffic from public resources

Without it, the public subnets would not be internet-accessible.

---

## 5. Public Route Table

You created a route table for the public subnets with:

* destination: `0.0.0.0/0`
* target: Internet Gateway

Associated with both public subnets.

### Result

Public subnet resources can communicate with the internet.

---

## 6. Application Tier (Private App Subnets)

You created two private application subnets:

* `private_app_subnet_az1`
* `private_app_subnet_az2`

These subnets are private because:

* `private_map_public_ip_on_launch = false`
* no direct route to the Internet Gateway
* use private routing

### Typical resources

* EC2 application servers
* ECS services
* backend APIs

These handle the application logic and are protected from direct internet exposure.

---

## 7. Data Tier (Private Data Subnets)

You created two private data subnets:

* `private_data_subnet_az1`
* `private_data_subnet_az2`

These subnets are the most secure layer.

### Typical resources

* RDS databases
* Redis / caching layers
* internal storage services

These should never be exposed to the internet.

---

## 8. NAT Gateway

You created a **NAT Gateway** in a public subnet.

The NAT Gateway allows:

* outbound internet access from private subnets
* downloading updates and external communication

At the same time:

* it blocks inbound internet traffic

This ensures private resources remain secure.

---

## 9. Private Route Tables

You created private route tables with:

* destination: `0.0.0.0/0`
* target: NAT Gateway

Associated with:

* application subnets
* data subnets

### Result

Private resources can reach the internet outbound, but are not reachable inbound.

---

## 10. Traffic Flow

### Inbound traffic flow

Internet
→ Internet Gateway
→ Public subnet (ALB)
→ Application subnet
→ Data subnet

---

### Outbound traffic flow

Application/Data subnet
→ Private route table
→ NAT Gateway
→ Internet

---

## 11. Why this design is strong

### Security

* Data tier is fully isolated
* Application tier is protected
* Only public tier is exposed

---

### High availability

* All tiers span two Availability Zones

---

### Scalability

You can extend this design by adding:

* ALB in public subnets
* Auto Scaling Groups in app subnets
* RDS Multi-AZ in data subnets

---

### Reusability

Because this is built as a Terraform module:

* you can reuse it across environments
* only variable values need to change

---

## 12. Terraform Design

This project uses a **modular Terraform structure**.

### Root module responsibilities

* provider configuration
* backend configuration
* passing input variables
* calling the VPC module
* exposing outputs

---

### Child module responsibilities

The `vpc` module creates:

* VPC
* public subnets
* private app subnets
* private data subnets
* Internet Gateway
* NAT Gateway
* route tables
* route table associations

---

## 13. Tagging Strategy

Common tagging ensures consistency:

```hcl
common_tags = {
  Project      = "ansu-3-tier-vpc"
  Environment  = "dev"
  ManagedBy    = "Terraform"
  Owner        = "Ansu"
  Architecture = "3-tier"
}
```

Example Name tag:

```hcl
Name = "ansu-3-tier-vpc-dev-private-data-subnet-az1"
```

---

## 14. Example Input Values

```hcl
region       = "us-east-1"
project_name = "ansu-3-tier-vpc"
environment  = "dev"

common_tags = {
  Project      = "ansu-3-tier-vpc"
  Environment  = "dev"
  ManagedBy    = "Terraform"
  Owner        = "Ansu"
  Architecture = "3-tier"
}

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

## 16. Interview Explanation

> I built a modular 3-tier VPC architecture in AWS using Terraform. The design separates public, application, and data layers across two availability zones for high availability and security. I implemented an Internet Gateway, NAT Gateway, and route tables to control traffic flow, and structured the code using reusable modules with centralized tagging for consistency across environments.

---

## 17. Future Enhancements

* Application Load Balancer (ALB)
* EC2 / ECS services
* RDS database layer
* Security groups module
* Monitoring and logging

