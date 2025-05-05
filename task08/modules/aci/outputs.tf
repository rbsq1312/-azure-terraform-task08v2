output "aci_id" {
  description = "The ID of the ACI"
  value       = azurerm_container_group.aci.id
}

output "aci_ip_address" {
  description = "The IP address of the ACI"
  value       = azurerm_container_group.aci.ip_address
}

output "aci_fqdn" {
  description = "The FQDN of the ACI"
  value       = azurerm_container_group.aci.fqdn
}
