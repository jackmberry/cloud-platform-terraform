resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "state" {
  source                = "./modules/state"
  resource_group_name   = var.resource_group_name
  storage_account_name  = var.storage_account_name
  container_name        = var.container_name
  location              = var.location
}

module "keyvvault" {
  source = "./modules/keyvault"
  key_vault_name        = var.key_vault_name
  location              = var.location
  resource_group_name   = var.resource_group_name
}

module "acr" {
  source                    = "./modules/acr"
  container_registry_name   = var.container_registry_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
}