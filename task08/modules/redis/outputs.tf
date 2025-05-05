output "redis_id" {
  description = "The ID of the Redis Cache"
  value       = azurerm_redis_cache.redis.id
}

output "redis_hostname" {
  description = "The hostname of the Redis Cache"
  value       = azurerm_redis_cache.redis.hostname
}

output "redis_primary_access_key" {
  description = "The primary access key of the Redis Cache"
  value       = azurerm_redis_cache.redis.primary_access_key
  sensitive   = true
}

output "redis_ssl_port" {
  description = "The SSL port of the Redis Cache"
  value       = azurerm_redis_cache.redis.ssl_port
}

output "redis_hostname_secret_name" {
  description = "The name of the Key Vault Secret for Redis hostname"
  value       = var.redis_hostname_secret_name
}

output "redis_primary_key_secret_name" {
  description = "The name of the Key Vault Secret for Redis primary key"
  value       = var.redis_primary_key_secret_name
}
