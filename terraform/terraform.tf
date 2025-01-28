# Azure provider block
provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

## ADD this in to migrate statefile to storage account once that has been provisioned
## Likely a cleaner way to do this. 
terraform {
  backend "azurerm" {
  }
}