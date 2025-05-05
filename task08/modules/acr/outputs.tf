output "acr_id" {
  description = "The ID of the ACR"
  value       = azurerm_container_registry.acr.id
}

output "acr_login_server" {
  description = "The login server URL of the ACR"
  value       = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  description = "The admin username of the ACR"
  value       = azurerm_container_registry.acr.admin_username
}

output "acr_admin_password" {
  description = "The admin password of the ACR"
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
}

output "docker_image_name" {
  description = "The name of the Docker image"
  value       = var.docker_image_name
}

output "docker_image_full_name" {
  description = "The full name of the Docker image (including registry)"
  value       = "${azurerm_container_registry.acr.login_server}/${var.docker_image_name}:latest"
}
