variable "resource_group_name" {
  description = "The name of the resource group in which to create the Key Vault"
  type        = string
}

variable "location" {
  description = "The location/region where the Key Vault is created"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "key_vault_sku" {
  description = "The SKU of the Key Vault"
  type        = string
  default     = "standard"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "tenant_id" {
  description = "The Azure Active Directory tenant ID to use for authenticating requests to Key Vault"
  type        = string
}

variable "current_user_object_id" {
  description = "The object ID of the current user or service principal"
  type        = string
}
