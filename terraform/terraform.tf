# Azure provider block
provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

terraform {
  backend "azurerm" {}
}