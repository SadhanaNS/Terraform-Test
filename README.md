# Learning Terraform by Building Azure Infrastructure

This repository is a hands-on project for learning Terraform by provisioning and managing Azure resources. It includes multiple environments and demonstrates best practices for folder structure, variable management, and state handling.

---

## Prerequisites
- Terraform installed (version 1.x or higher)
- Azure CLI installed
- Azure account with proper credentials and Subscription ID
- Basic knowledge of Terraform concepts (providers, resources, variables)

---

## Folder Structure

repo-root/
├─ README.md
├─ main.tf
├─ variables.tf
├─ outputs.tf
├─ .gitignore
└─ envs/
├─ dev/
│ ├─ main.tf
│ └─ var.tf
└─ prod/
├─ main.tf
└─ var.tf

- `main.tf` – main configuration file for root-level resources (if any).  
- `variables.tf` – input variables for the project.  
- `outputs.tf` – output variables for easy reference.  
- `.gitignore` – ignores sensitive files like `.tfstate` and `.terraform/`.  
- `envs/` – environment-specific folders (`dev`, `prod`). Each contains its own Terraform configuration and variables.  

---

## Setup & Usage

1. **Initialize Terraform** (installs providers and sets up backend):

terraform init
terraform plan
terraform apply --auto-approve
terraform destroy --auto-approve
terraform detsroy -target='instance-type.instance-name'

## Learning Notes

1. deleting public IP address will delete all associated resources such as NIC and Virtual machine.

2. command to delete single resource: terraform detsroy -target='instance-type.instance-name'

