terraform {    
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 5.14.0"
        }
    }
    backend "azurerm" {
      resource_group_name  = "tfstate-day04"
      storage_account_name = "day0423713"
      container_name       = "tfstate"
      key                  = "dev.terraform.tfstate"
  }
  required_version = ">= 1.9.0"
}

provider "azurerm" {
  features {}
  subscription_id = "6b6b1770-c87e-43b4-9875-21c5c387e68a"
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
