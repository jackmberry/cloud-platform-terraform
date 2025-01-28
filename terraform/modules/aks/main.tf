# Create Resource Group
resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.location
}

# Create Virtual Network
resource "azurerm_virtual_network" "aks_vnet" {
  name                = "${var.resource_group_name}-vnet"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  address_space       = ["10.0.0.0/16"]
}

# Create Subnet
resource "azurerm_subnet" "aks_subnet" {
  name                 = "${var.resource_group_name}-subnet"
  resource_group_name  = azurerm_resource_group.aks.name
  virtual_network_name = azurerm_virtual_network.aks_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}




# Create AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = "${var.aks_cluster_name}-dns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = var.node_vm_size
    vnet_subnet_id = azurerm_subnet.aks_subnet.id
  }

  network_profile {
    network_plugin     = "azure"
    service_cidr       = "10.1.0.0/16" # Non-conflicting range
    dns_service_ip     = "10.1.0.10"   # Must be within service_cidr
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Dev"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "work_node_pool" {
  name                    = "workerpool"  
  kubernetes_cluster_id   = azurerm_kubernetes_cluster.aks.id  
  vm_size                 = "Standard_DS1_v2"  
  node_count              = 1
  max_pods                = 50  
  auto_scaling_enabled    = false  
  mode                    = "User" 
  os_disk_size_gb         = 50
  vnet_subnet_id          = azurerm_subnet.aks_subnet.id

  tags = {
    environment = "Dev"
  }
}
