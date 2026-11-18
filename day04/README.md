# Day 04 - Terraform - The State File

## Overview
 Terraform keeps a record of every resource it manages in a state file (terraform.tfstate). This document explains what the state file is, why it matters, and how to store it safely in an Azure Blob Storage remote backend.
Audience: engineers who know basic Terraform (init, plan, apply) and have access to an Azure subscription.
Prerequisites
• Terraform installed
• Azure CLI installed and authenticated (az login)
• Permission to create resource groups and storage accounts in the target subscription

 
