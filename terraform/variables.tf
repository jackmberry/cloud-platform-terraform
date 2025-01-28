variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

# Variables for dynamic configuration
variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "UK South"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "aks_cluster_name" {
  description = "Name for the AKS cluster"
  type        = string
}