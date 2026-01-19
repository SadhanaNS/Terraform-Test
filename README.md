"Learning Terraform by building Azure infrastructure”

Prerequisites

Terraform version.

Cloud provider CLI installed (e.g., Azure CLI).

Account setup (credentials, environment variables, Subscription id).

Folder Structure:repo-root/
├─ README.md
├─ main.tf
├─ variables.tf
├─ outputs.tf
├─ .gitignore
└─ envs/
   ├─ dev/
   │  └─ main.tf
         var.tf
   └─ prod/
      └─ main.tf
         var.tf
