terraform {    
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 5.14.0"
        }
    }
  /*  backend "azurerm" {
      resource_group_name  = "tfstate-day04"
      storage_account_name = "day0423713"
      container_name       = "tfstate"
      key                  = "dev.terraform.tfstate"
  } */
  required_version = ">= 1.9.0"
}

provider "azurerm" {
  features {}
  subscription_id =  "<subscription_id>" # Use your subscription id from azure portal
}

variable "environment" {
  description = "The stagging environment for the resources created by Naveed"
  type        = string
  default     = "staging"

}

resource "azurerm_resource_group" "example" {
  name     = "rg-terraform-demo-naveed"
  location = "East US"
}

locals {
  common_tags = {
    environment = "dev"
    lob = "banking"
    stage = "alpha"
  } 
  
}

resource "azurerm_storage_account" "example" {
  name                     = "storage4terraformnaveed" # must be globally unique, 3-24 lowercase letters/numbers
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Cool"

  tags = {
    environment = local.common_tags.stage
    
  }
}

output "storage_account_name" {
  value = azurerm_storage_account.example.name
  description = "Storage test by Naveed"
}

output "storage_account_primary_access_key" {
  value       = azurerm_storage_account.example.primary_access_key
  description = "Primary access key for the storage account"
  sensitive   = true
}




