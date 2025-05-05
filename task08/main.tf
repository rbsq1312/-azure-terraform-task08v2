data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = local.common_tags
}

module "keyvault" {
  source                 = "./modules/keyvault"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  key_vault_name         = local.keyvault_name
  key_vault_sku          = var.key_vault_sku
  tags                   = local.common_tags
  tenant_id              = data.azurerm_client_config.current.tenant_id
  current_user_object_id = data.azurerm_client_config.current.object_id
}

module "redis" {
  source                        = "./modules/redis"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  redis_name                    = local.redis_name
  redis_capacity                = var.redis_capacity
  redis_family                  = var.redis_family
  redis_sku                     = var.redis_sku
  tags                          = local.common_tags
  key_vault_id                  = module.keyvault.key_vault_id
  redis_hostname_secret_name    = "redis-hostname"
  redis_primary_key_secret_name = "redis-primary-key"

  depends_on = [
    module.keyvault
  ]
}

module "acr" {
  source              = "./modules/acr"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  acr_name            = local.acr_name
  acr_sku             = var.acr_sku
  tags                = local.common_tags
  docker_image_name   = local.docker_image_name
  git_repo_url        = var.git_repo_url
  git_branch          = var.git_branch
  git_pat             = var.git_pat
  dockerfile_path     = "Dockerfile" # Corrected path
  docker_context_path = "task08/application"
}

module "aks" {
  source              = "./modules/aks"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  aks_name            = local.aks_name
  tags                = local.common_tags
  dns_prefix          = local.aks_name
  node_pool_name      = var.aks_node_pool_name
  node_count          = var.aks_node_count
  vm_size             = var.aks_vm_size      # Ensure this uses the corrected value via tfvars/env
  os_disk_type        = var.aks_os_disk_type # Ensure this uses the required value via tfvars/env
  acr_id              = module.acr.acr_id
  key_vault_id        = module.keyvault.key_vault_id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  key_vault_name      = module.keyvault.key_vault_name

  depends_on = [
    module.acr,
    module.keyvault
  ]
}

module "aci" {
  source                        = "./modules/aci"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  aci_name                      = local.aci_name
  aci_sku                       = var.aci_sku
  tags                          = local.common_tags
  docker_image                  = module.acr.docker_image_full_name
  acr_login_server              = module.acr.acr_login_server
  acr_admin_username            = module.acr.acr_admin_username
  acr_admin_password            = module.acr.acr_admin_password
  redis_url                     = module.redis.redis_hostname
  redis_password                = module.redis.redis_primary_access_key
  key_vault_id                  = module.keyvault.key_vault_id
  redis_hostname_secret_name    = module.redis.redis_hostname_secret_name
  redis_primary_key_secret_name = module.redis.redis_primary_key_secret_name
  redis_port                    = module.redis.redis_ssl_port
  redis_ssl_mode                = true

  depends_on = [
    module.acr,
    module.redis
  ]
}

# Kubernetes manifests for deploying the application to AKS
resource "kubectl_manifest" "secret_provider_class" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    kv_name                    = module.keyvault.key_vault_name
    redis_url_secret_name      = module.redis.redis_hostname_secret_name
    redis_password_secret_name = module.redis.redis_primary_key_secret_name
    tenant_id                  = data.azurerm_client_config.current.tenant_id
    aks_kv_access_identity_id  = module.aks.aks_kv_identity_client_id
  })

  depends_on = [
    module.aks
  ]
}

resource "kubectl_manifest" "service" {
  yaml_body = file("${path.module}/k8s-manifests/service.yaml")

  depends_on = [
    kubectl_manifest.secret_provider_class
  ]
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.acr_login_server
    app_image_name   = module.acr.docker_image_name
    image_tag        = local.docker_image_tag
  })

  # Add this line to prevent timeout during rollout check
  wait_for_rollout = false

  # Ensure the wait_for block is removed or commented out
  # wait_for {
  #   field {
  #     key   = "status.readyReplicas"
  #     value = "1"
  #   }
  # }

  depends_on = [
    kubectl_manifest.service
  ]
}

# Get the LoadBalancer IP address
data "kubernetes_service" "app_service" {
  metadata {
    name = "redis-flask-app-service"
  }

  depends_on = [
    kubectl_manifest.service,
    kubectl_manifest.deployment # Still depend on deployment apply starting
  ]
}
