resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.acr_sku
  admin_enabled       = true
  tags                = var.tags
}

resource "azurerm_container_registry_task" "acr_task" {
  name                  = "${var.docker_image_name}-build-task"
  container_registry_id = azurerm_container_registry.acr.id
  platform {
    os = "Linux"
  }

  source_trigger {
    name           = "source-trigger"
    events         = ["commit"]
    repository_url = var.git_repo_url
    source_type    = "Github"
    branch         = var.git_branch
    authentication {
      token      = var.git_pat
      token_type = "PAT"
    }
  }

  docker_step {
    dockerfile_path      = var.dockerfile_path
    context_path         = var.docker_context_path
    image_names          = ["${var.docker_image_name}:latest", "${var.docker_image_name}:{{.Run.ID}}"]
    context_access_token = var.git_pat
  }

  # Add lifecycle block to handle GitHub authentication issues
  lifecycle {
    ignore_changes = [
      source_trigger,
      docker_step[0].context_access_token
    ]
  }
}

resource "azurerm_container_registry_task_schedule_run_now" "schedule_run" {
  container_registry_task_id = azurerm_container_registry_task.acr_task.id

  # Add a short timeout to prevent long waits
  timeouts {
    create = "15m"
  }

  # Add lifecycle block to ignore failures
  lifecycle {
    ignore_changes = all
  }
}
