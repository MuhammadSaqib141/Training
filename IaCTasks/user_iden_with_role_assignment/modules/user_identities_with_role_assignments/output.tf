output "flattened_role_assignments" {
  value = local.flattened_role_assignments
}

output "resource_id_map" {
  value = local.resource_id_map
}

output "accounts" {
  value = data.azurerm_storage_account.storage_account
}

output "service_buses" {
  value = data.azurerm_servicebus_namespace.service_bus_namespace
}