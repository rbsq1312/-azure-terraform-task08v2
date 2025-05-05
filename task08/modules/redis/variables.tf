variable "resource_group_name" {
  description = "The name of the resource group in which to create the Redis Cache"
  type        = string
}

variable "location" {
  description = "The location/region where the Redis Cache is created"
  type        = string
}

variable "redis_name" {
  description = "The name of the Redis Cache"
  type        = string
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

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "key_vault_id" {
  description = "The ID of the Key Vault where Redis secrets will be stored"
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "The name of the Key Vault Secret for Redis hostname"
  type        = string
  default     = "redis-hostname"
}

variable "redis_primary_key_secret_name" {
  description = "The name of the Key Vault Secret for Redis primary key"
  type        = string
  default     = "redis-primary-key"
}
