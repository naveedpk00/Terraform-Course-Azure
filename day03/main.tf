

terraform {    
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 5.14.0"
        }
    }
    required_version = ">= 1.9.0"
}

provider "azurerm" {
  features {}
  subscription_id = "<subscription_id>" # get your subscription id from azure portal
}

resource "azurerm_resource_group" "example" {
  name     = "rg-terraform-demo-naveed"
  location = "East US"
}


resource "azurerm_storage_account" "example" {
  name                     = "storage4terraformnaveed" # must be globally unique, 3-24 lowercase letters/numbers
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = "Cool"

  tags = {
    environment = "staging"
  }
}
