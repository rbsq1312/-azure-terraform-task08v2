variable "resource_group_name" {
  description = "The name of the resource group in which to create the ACR"
  type        = string
}

variable "location" {
  description = "The location/region where the ACR is created"
  type        = string
}

variable "acr_name" {
  description = "The name of the ACR"
  type        = string
}

variable "acr_sku" {
  description = "The SKU of the ACR"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "docker_image_name" {
  description = "The name of the Docker image to build"
  type        = string
}

variable "git_repo_url" {
  description = "The URL of the Git repository containing the application source"
  type        = string
}

variable "git_branch" {
  description = "The branch of the Git repository to use"
  type        = string
  default     = "main"
}

variable "git_pat" {
  description = "The Personal Access Token for the Git repository"
  type        = string
  sensitive   = true
}

variable "dockerfile_path" {
  description = "The path to the Dockerfile in the Git repository"
  type        = string
  default     = "Dockerfile"
}

variable "docker_context_path" {
  description = "The path to the Docker context in the Git repository"
  type        = string
  default     = "."
}
