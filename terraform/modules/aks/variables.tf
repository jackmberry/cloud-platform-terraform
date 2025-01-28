variable "aks_cluster_name" {
    type    = string
}

variable "node_count" {
    type = number
    default = 2
}

variable "node_vm_size" {
    type = string
    default     = "Standard_B2s"
}

variable "resource_group_name" {
    type    = string
}
 
variable "location" {
    type    = string
    default = "uksouth"
}
