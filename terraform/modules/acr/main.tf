# Create Azure Container Registry
# Create a Service Principal
data "azuread_client_config" "current" {}

resource "azuread_application" "acr_sp" {
  display_name = "${var.container_registry_name}-acr-sp"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "acr_sp" {
  client_id                    = azuread_application.acr_sp.client_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal_password" "acr_sp_password" {
  service_principal_id = azuread_service_principal.acr_sp.id
  end_date             = "2099-12-31T23:59:59Z" # Set an appropriate expiration date
}

resource "azurerm_container_registry" "acr" {
  name                = var.container_registry_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"

  admin_enabled = false
  tags = {
    environment = "dev"
  }
}

# Assign the Role to the Service Principal
resource "azurerm_role_assignment" "acr_role_assignment" {
  principal_id         = azuread_service_principal.acr_sp.object_id
  role_definition_name = "AcrPush" # Change to AcrPull if only pull access is needed
  scope                = azurerm_container_registry.acr.id
}