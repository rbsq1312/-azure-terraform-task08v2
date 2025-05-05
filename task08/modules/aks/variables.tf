variable "resource_group_name" {
  description = "The name of the resource group in which to create the AKS"
  type        = string
}

variable "location" {
  description = "The location/region where the AKS is created"
  type        = string
}

variable "aks_name" {
  description = "The name of the AKS"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "dns_prefix" {
  description = "DNS prefix specified when creating the managed cluster"
  type        = string
  default     = "aks"
}

variable "node_pool_name" {
  description = "The name of the default node pool"
  type        = string
  default     = "system"
}

variable "node_count" {
  description = "The number of nodes in the default node pool"
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "The size of the Virtual Machine in the default node pool"
  type        = string
  default     = "Standard_D2ads_v5"
}

variable "os_disk_type" {
  description = "The type of OS disk in the default node pool"
  type        = string
  default     = "Ephemeral"
}

variable "acr_id" {
  description = "The ID of the ACR"
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "The Azure Active Directory tenant ID"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}
