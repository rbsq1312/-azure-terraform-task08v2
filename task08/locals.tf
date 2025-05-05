locals {
  name_prefix   = var.name_prefix
  rg_name       = "${local.name_prefix}-rg"
  aci_name      = "${local.name_prefix}-ci"
  acr_name      = replace("${local.name_prefix}cr", "-", "") # ACR name cannot contain hyphens
  aks_name      = "${local.name_prefix}-aks"
  keyvault_name = "${local.name_prefix}-kv"
  redis_name    = "${local.name_prefix}-redis"

  common_tags = {
    Creator = var.creator
  }

  # Docker image details
  docker_image_name = "${local.name_prefix}-app"
  docker_image_tag  = "latest"
}
