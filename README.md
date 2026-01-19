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
   │  ├─ main.tf
   │  └─ var.tf
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

1. terraform init
2. terraform plan
3. terraform apply --auto-approve
4. terraform destroy --auto-approve
5. terraform detsroy -target='instance-type.instance-name'

## Learning Notes

1. Deleting a public IP address in Azure can cascade and delete associated resources like NICs and Virtual Machines, depending on dependency relationships. Always check the dependency graph (terraform graph) before deleting.

2. Use the -target flag with caution; it only deletes specified resources but can break dependencies.

3. creation of infrastructure for multiple envritonment can be managed from multiple directories.

## Run DEV
```bash
cd envs/dev
terraform init
terraform plan
terraform apply
```

## Run Prod
```bash
cd envs/prod
terraform init
terraform plan
terraform apply
```

4. In Terraform, a module variable does not need a default value. If a variable has no default, it becomes required. You then pass it explicitly from the calling module (often main.tf).