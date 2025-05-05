resource "azurerm_container_group" "aci" {
  name                = var.aci_name
  location            = var.location
  resource_group_name = var.resource_group_name
  ip_address_type     = "Public"
  dns_name_label      = var.aci_name
  os_type             = "Linux"
  tags                = var.tags

  container {
    name   = "app"
    image  = var.docker_image
    cpu    = "1.0"
    memory = "1.5"

    ports {
      port     = 8080
      protocol = "TCP"
    }

    environment_variables = {
      "CREATOR"        = "ACI"
      "REDIS_PORT"     = tostring(var.redis_port)
      "REDIS_SSL_MODE" = var.redis_ssl_mode ? "true" : "false"
    }

    secure_environment_variables = {
      "REDIS_URL" = var.redis_url
      "REDIS_PWD" = var.redis_password
    }
  }

  image_registry_credential {
    server   = var.acr_login_server
    username = var.acr_admin_username
    password = var.acr_admin_password
  }
}
