variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "cmtr-49b8ddc2-mod8"
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "West Europe"
}

variable "creator" {
  description = "The creator of the resources"
  type        = string
  default     = "theodor-laurentiu_robescu@epam.com"
}

variable "git_repo_url" {
  description = "The URL of the Git repository containing the application source"
  type        = string
}

variable "git_branch" {
  description = "The branch of the Git repository to use"
  type        = string
  default     = "main"
}

variable "git_pat" {
  description = "The Personal Access Token for the Git repository"
  type        = string
  sensitive   = true
}

variable "redis_capacity" {
  description = "The size of the Redis Cache"
  type        = number
  default     = 2
}

variable "redis_family" {
  description = "The family of the Redis Cache"
  type        = string
  default     = "C"
}

variable "redis_sku" {
  description = "The SKU of the Redis Cache"
  type        = string
  default     = "Basic"
}

variable "key_vault_sku" {
  description = "The SKU of the Key Vault"
  type        = string
  default     = "standard"
}

variable "acr_sku" {
  description = "The SKU of the ACR"
  type        = string
  default     = "Basic"
}

variable "aci_sku" {
  description = "The SKU of the ACI"
  type        = string
  default     = "Standard"
}

variable "aks_node_pool_name" {
  description = "The name of the default node pool in AKS"
  type        = string
  default     = "system"
}

variable "aks_node_count" {
  description = "The number of nodes in the default node pool in AKS"
  type        = number
  default     = 1
}

variable "aks_vm_size" {
  description = "The size of the Virtual Machine in the default node pool in AKS"
  type        = string
  default     = "Standard_D2ads_v5"
}

variable "aks_os_disk_type" {
  description = "The type of OS disk in the default node pool in AKS"
  type        = string
  default     = "Ephemeral"
}
