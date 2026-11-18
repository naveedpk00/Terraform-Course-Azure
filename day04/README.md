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
