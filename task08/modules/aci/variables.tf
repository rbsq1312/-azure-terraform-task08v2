variable "resource_group_name" {
  description = "The name of the resource group in which to create the ACI"
  type        = string
}

variable "location" {
  description = "The location/region where the ACI is created"
  type        = string
}

variable "aci_name" {
  description = "The name of the ACI"
  type        = string
}

variable "aci_sku" {
  description = "The SKU of the ACI"
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "docker_image" {
  description = "The Docker image to use for the container"
  type        = string
}

variable "acr_login_server" {
  description = "The login server of the ACR"
  type        = string
}

variable "acr_admin_username" {
  description = "The admin username of the ACR"
  type        = string
}

variable "acr_admin_password" {
  description = "The admin password of the ACR"
  type        = string
  sensitive   = true
}

variable "redis_url" {
  description = "The hostname of the Redis Cache"
  type        = string
}

variable "redis_password" {
  description = "The primary access key of the Redis Cache"
  type        = string
  sensitive   = true
}

variable "key_vault_id" {
  description = "The ID of the Key Vault where secrets are stored"
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "The name of the Key Vault Secret for Redis hostname"
  type        = string
}

variable "redis_primary_key_secret_name" {
  description = "The name of the Key Vault Secret for Redis primary key"
  type        = string
}

variable "redis_port" {
  description = "The port on which Redis is listening"
  type        = number
  default     = 6380
}

variable "redis_ssl_mode" {
  description = "Whether to use SSL for Redis connection"
  type        = bool
  default     = true
}
