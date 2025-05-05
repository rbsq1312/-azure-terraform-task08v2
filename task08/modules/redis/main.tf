resource "azurerm_redis_cache" "redis" {
  name                 = var.redis_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  capacity             = var.redis_capacity
  family               = var.redis_family
  sku_name             = var.redis_sku
  non_ssl_port_enabled = false # Using the non-deprecated property name
  minimum_tls_version  = "1.2"
  tags                 = var.tags
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = var.redis_hostname_secret_name
  value        = azurerm_redis_cache.redis.hostname
  key_vault_id = var.key_vault_id

  # Add lifecycle block to handle conflicts with existing secrets
  lifecycle {
    ignore_changes = all
  }
}

resource "azurerm_key_vault_secret" "redis_primary_key" {
  name         = var.redis_primary_key_secret_name
  value        = azurerm_redis_cache.redis.primary_access_key
  key_vault_id = var.key_vault_id

  # Add lifecycle block to handle conflicts with existing secrets
  lifecycle {
    ignore_changes = all
  }
}
