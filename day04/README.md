# Day 04 - Terraform - The State File

## 1. Overview
 Terraform keeps a record of every resource it manages in a state file (terraform.tfstate). This document explains what the state file is, why it matters, and how to store it safely in an Azure Blob Storage remote backend.
 
Audience: engineers who know basic Terraform (init, plan, apply) and have access to an Azure subscription.

### Prerequisites
- Terraform installed
- Azure CLI installed and authenticated (az login)
- Permission to create resource groups and storage accounts in the target subscription

## 2. What the State File Is
The state file is a JSON document that maps the resources declared in your .tf files to the real objects that exist in your cloud account.
When you run terraform plan or terraform apply, Terraform compares three things:
- 1.  Desired state: what your .tf configuration says should exist.
- 2.  State file: what Terraform last recorded as existing.
- 3.  Actual state: what really exists in the cloud (refreshed during plan).
Terraform then calculates the changes needed so that desired state = actual state.

## 3. Why the State File Matters
<img width="548" height="351" alt="Screenshot 2026-11-19 095210" src="https://github.com/user-attachments/assets/90aefd66-9f47-4e3a-9f13-cf9e86000fd9" />

Security note: Because the state file can contain secrets, treat it like a credential. Restrict access to it and never commit it to version control.

## 4. Why Not Use Local State
By default Terraform writes terraform.tfstate to the working directory. This is fine for experiments but causes problems in real use:
- It is not shared, so teammates cannot work on the same infrastructure safely.
- It has no locking, so concurrent runs can corrupt it.
- It is easy to lose or accidentally commit to Git.
A remote backend solves these problems. This guide uses Azure Blob Storage.

## 5. Setting Up the Azure Remote Backend
### 5.1 Create the storage resources
The following script (backend.sh) creates a resource group, a storage account, and a blob container to hold the state.

```
#!/bin/bash
# Create resource group and storage for Terraform state
RES_GRP="rg-terraform-state-naveed"
SA_NAME="ststatefilenaveed"
CONTAINER="tfstate"

az group create -n $RES_GRP -l eastus
az storage account create -n $SA_NAME -g $RES_GRP --sku Standard_LRS
az storage container create -n $CONTAINER --account-name $SA_NAME
```
Notes
- Storage account names must be globally unique, 3 to 24 characters, lowercase letters and numbers only. Change SA_NAME if the name is taken.
- Standard_LRS is the lowest-cost redundancy option. Consider GRS or ZRS for production.
- Create these resources outside the Terraform configuration that will use them. Otherwise the backend would depend on itself.

### 5.2 Configure the backend in main.tf
```
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state-naveed"
    storage_account_name = "ststatefilenaveed"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
```
<img width="609" height="196" alt="Screenshot 2026-11-19 095516" src="https://github.com/user-attachments/assets/efe2a337-f7c4-4596-8876-d5b87adf390e" />

### 5.3 Initialize and migrate
```
terraform init
```
If you already have local state, Terraform detects the backend change and offers to copy the existing state to the remote backend. Confirm with yes. You can also run terraform init -migrate-state explicitly.

### 5.4 Verify
- Check the container in the Azure portal (or with az storage blob list) and confirm the terraform.tfstate blob exists.
- Run terraform plan. It should report no unexpected changes.
- Once migrated, delete the leftover local terraform.tfstate and .backup files.

## 6. Best Practices
- 1.  Store state remotely. Use a shared backend and never commit terraform.tfstate to Git. Add it to .gitignore:
 ```
     *.tfstate
    *.tfstate.*
    .terraform/
```
- 2.  Use state locking. Locking prevents two runs from modifying state at once. The azurerm backend does this automatically using blob leases.
- 3.  Encrypt state. Azure Storage encrypts data at rest by default, and access over HTTPS protects it in transit.
- 4.  Enable backups. Turn on blob soft delete and versioning so you can recover from accidental deletion or corruption:
 ```
    az storage account blob-service-properties update \
      --account-name ststatefilenaveed \
      --resource-group rg-terraform-state-naveed \
      --enable-versioning true \
      --enable-delete-retention true \
      --delete-retention-days 14
```
- 5.  Isolate environments. Use a separate state per environment (Dev, Staging, Prod), either with Terraform workspaces or with a different key per directory, for example dev/terraform.tfstate and prod/terraform.tfstate.
- 6.  Limit access. Grant access to the storage account only to people and pipelines that need it, using Azure RBAC, since the state may contain secrets.
 
## 7. Troubleshooting

<img width="699" height="375" alt="Screenshot 2026-11-19 095911" src="https://github.com/user-attachments/assets/088371dd-aa6c-4fe6-863b-9b52ec56fb2c" />

## 8. Summary
- The state file is how Terraform maps your code to real infrastructure, so protect it.
- Keep it in a remote backend, with locking, encryption, and backups enabled.
- Keep environments isolated and never commit state to Git.
- Azure Blob Storage provides all of this with minimal setup.

/

