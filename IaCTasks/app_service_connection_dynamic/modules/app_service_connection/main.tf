resource "azurerm_app_service_connection" "example" {
  name               = var.app_service_name
  app_service_id     = var.app_service_id
  target_resource_id = var.target_resource_id

  authentication {
    type = var.auth_type
  }
}