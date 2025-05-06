output "aci_fqdn" {
  description = "FQDN of App in Azure Container Instance"
  value       = module.aci.aci_fqdn
}

output "aks_lb_ip" {
  description = "Load balancer ip address req for the test"
  value       = data.kubernetes_service.app.status[0].load_balancer[0].ingress[0].ip
}
