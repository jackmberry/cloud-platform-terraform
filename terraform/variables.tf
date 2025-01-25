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

variable "storage_account_name" {
  description = "Name of the Azure Storage Account for storing Terraform state"
  type        = string
}

variable "container_name" {
  description = "Name of the blob container for Terraform state"
  type        = string
}

variable "container_registry_name" {
  description = "Name of the environments container registry"
  type = string
}

variable "key_vault_name" {
  description = "Name of the KeyVault to create for the environment"
  type = string
}