# Terraform AWS Infrastructure Automation

A production-style **Infrastructure as Code (IaC)** project that provisions AWS infrastructure using **Terraform modules**, remote state management, and CI/CD automation with **GitHub Actions**.

This project demonstrates how DevOps engineers automate cloud infrastructure deployment using modular Terraform architecture and best practices.

---

# Architecture Overview

```
GitHub (CI/CD)
      │
      ▼
Terraform
      │
      ▼
AWS Infrastructure
│
├── VPC
│   ├── Public Subnet
│   │   └── EC2 Instances
│   ├── Private Subnet
│   └── Internet Gateway
│
├── S3 Bucket (Storage)
│
└── Remote Terraform State
    ├── S3 Bucket
    └── DynamoDB Lock Table
```

---

# Technologies Used

| Technology | Purpose |
|---|---|
| Terraform | Infrastructure as Code |
| AWS | Cloud Infrastructure |
| EC2 | Compute Instances |
| VPC | Network Isolation |
| S3 | Object Storage |
| DynamoDB | Terraform State Locking |
| GitHub | Version Control |
| GitHub Actions | CI/CD Pipeline |
| AWS CLI | AWS Resource Management |

---

# Project Structure

```
terraform-aws-infra
│
├── modules
│   ├── vpc
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── ec2
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── s3
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── environments
│   └── dev
│       ├── main.tf
│       ├── variables.tf
│       └── terraform.tfvars
│
├── backend
      |-- backend.tf
├── provider.tf
└── .github/workflows/terraform.yml
```

This modular architecture allows **reusable infrastructure components across environments**.

---

# Features Implemented

- Modular Terraform architecture
- AWS VPC networking setup
- Automated EC2 instance provisioning
- S3 bucket storage
- Remote Terraform state management
- DynamoDB state locking
- CI/CD pipeline using GitHub Actions

---

# Step-by-Step Implementation

## 1. Environment Setup

Install required tools:

- Terraform
- AWS CLI
- Git

Verify installations:

```bash
terraform -v
aws --version
git --version
```

---

# 2. Configure AWS Credentials

Authenticate local environment with AWS.

```bash
aws configure
```

Provide:

```
AWS Access Key
AWS Secret Access Key
Region: ap-south-1
```

---

# 3. Create Terraform Project Structure

Create project directory:

```bash
mkdir terraform-aws-infra
cd terraform-aws-infra
```

Create folders:

```bash
mkdir modules
mkdir environments
mkdir environments/dev
mkdir backend
```

This structure follows **industry Terraform best practices**.

---

# 4. Configure AWS Provider

File:

```
provider.tf
```

Example configuration:

```hcl
provider "aws" {
  region = "ap-south-1"
}
```

This defines the cloud provider used by Terraform.

---

# 5. Build VPC Module

The VPC module provisions the **network layer**.

Resources created:

- VPC
- Public Subnet
- Private Subnet
- Internet Gateway
- Route Tables

Example resource:

```hcl
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}
```

Outputs expose:

- vpc_id
- public_subnet_id
- private_subnet_id

These outputs are used by other modules.

---

# 6. Build EC2 Module

The EC2 module provisions **compute resources**.

Resources created:

- Security Group
- EC2 instances

Example:

```hcl
resource "aws_instance" "web" {
  count         = 3
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
}
```

Features:

- configurable instance types
- reusable module
- automatic instance creation using `count`

---

# 7. Build S3 Module

The S3 module creates storage infrastructure.

Resources:

- S3 bucket
- bucket versioning

Example:

```hcl
resource "aws_s3_bucket" "storage" {
  bucket = var.bucket_name
}
```

Versioning protects data from accidental deletion.

---

# 8. Environment Configuration

The **dev environment** calls the modules.

Example:

```hcl
module "vpc" {
  source = "../../modules/vpc"
}

module "ec2" {
  source    = "../../modules/ec2"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id
}

module "s3" {
  source      = "../../modules/s3"
  bucket_name = "project-bucket"
}
```

This demonstrates **Terraform module composition**.

---

# 9. Deploy Infrastructure

Initialize Terraform:

```bash
terraform init
```

Check execution plan:

```bash
terraform plan
```

Apply infrastructure:

```bash
terraform apply
```

Terraform automatically provisions AWS resources.

---

# 10. Configure Remote Terraform State

Terraform state is stored in:

- **S3 bucket**
- **DynamoDB lock table**

Backend configuration example:

```hcl
terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
  }
}
```

Benefits:

- secure state storage
- team collaboration
- state locking

---

# 11. CI/CD Pipeline with GitHub Actions

Workflow file:

```
.github/workflows/terraform.yml
```

Pipeline tasks:

1. Checkout repository
2. Configure AWS credentials
3. Initialize Terraform
4. Run Terraform plan

Example step:

```yaml
- name: Terraform Init
  run: terraform init
  working-directory: environments/dev
```

This automates infrastructure validation when code is pushed.

---

# How to Run the Project

Clone repository:

```bash
git clone https://github.com/kumargorav-cloud/terraform-aws-infra.git
```

Initialize Terraform:

```bash
terraform init
```

Run plan:

```bash
terraform plan
```

Deploy infrastructure:

```bash
terraform apply
```

---

# Infrastructure Provisioned

This project automatically creates:

- VPC
- Public and Private Subnets
- Internet Gateway
- EC2 Instances
- S3 Bucket
- Remote Terraform Backend

---

# Security Best Practices Implemented

- Remote Terraform state storage
- State locking with DynamoDB
- Modular Terraform architecture
- Use of variables for configuration
- `.gitignore` to protect Terraform state files

---

# Future Improvements

Possible enhancements:

- Application Load Balancer
- Auto Scaling Groups
- Terraform Workspaces
- Multi-environment deployments
- Monitoring with Prometheus & Grafana

---

# Author

**Gorav Kumar**

Cloud Engineer | DevOps Enthusiast

GitHub:  
https://github.com/kumargorav-cloud
