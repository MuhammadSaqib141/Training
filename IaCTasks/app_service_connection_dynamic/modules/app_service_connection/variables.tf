variable "app_service_name" {
  description = "The name of the app service connection."
  type        = string
}

variable "app_service_id" {
  description = "ID of the app service"
  type        = string
}

variable "target_resource_id" {
  description = "ID of the target resource"
  type        = string
}

variable "auth_type" {
  description = "The resource group name where the function app and target resource exist."
  type        = string
}