# resource "azurerm_app_service_connection" "example" {
#   name = var.app_service_name
#   app_service_id   = data.azurerm_linux_function_app.function_app.id
#   target_resource_id = data.azurerm_storage_account.target_resource.id

#   authentication {
#     type = var.auth_type
#   }
# }

# data "azurerm_linux_function_app" "function_app" {
#   name                = var.function_app_name
#   resource_group_name = var.resource_group_name
# }

# data "azurerm_storage_account" "target_resource" {
#   name                = var.target_resource_name
#   resource_group_name = var.resource_group_name
# }


# output "app_service_connection_id" {
#   description = "The ID of the created app service connection."
#   value       = azurerm_app_service_connection.example.id
# }

variable "app_service_id" {
  description = "ID of the app service"
  type        = string
}

variable "target_resource_id" {
  description = "ID of the target resource"
  type        = string
}

resource "azurerm_app_service_connection" "example" {
  name               = var.app_service_name
  app_service_id     = var.app_service_id
  target_resource_id = var.target_resource_id

  authentication {
    type = var.auth_type
  }
}