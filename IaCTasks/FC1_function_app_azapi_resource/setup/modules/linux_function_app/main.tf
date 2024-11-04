resource "azurerm_linux_function_app" "example" {
  name                = var.function_app_name
  resource_group_name = var.resource_group_name
  location            = var.location

  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  service_plan_id            = var.service_plan_id

  site_config {}
}

output "linux_function_app_id" {
  value = azurerm_linux_function_app.example.id
}


output "linux_function_app_name" {
  value = var.function_app_name
}