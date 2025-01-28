resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "aks" {
  source                    = "./modules/aks"
  aks_cluster_name          = var.aks_cluster_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
}