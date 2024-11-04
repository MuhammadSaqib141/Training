resource "azurerm_service_plan" "example" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name = var.sku_size

}

output "service_plan_id" {
  value = azurerm_service_plan.example.id
}
