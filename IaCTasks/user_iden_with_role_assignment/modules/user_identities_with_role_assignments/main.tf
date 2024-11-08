resource "azurerm_user_assigned_identity" "example" {
  location            = var.resource_group_location
  name                = var.user_identity_name
  resource_group_name = var.resource_group_name
}

output "identity" {
  value = azurerm_user_assigned_identity.example
}

data "azurerm_storage_account" "storage_account" {
  for_each = { 
    for resource_name in flatten([
      for res in var.role_assignments : [
        for name in res.resource_names :
        name if res.resource_type == "storage_account"
      ]
    ]) : resource_name => resource_name 
  }

  name                = each.key
  resource_group_name = var.resource_group_name
}

data "azurerm_servicebus_namespace" "service_bus_namespace" {
  for_each = { 
    for resource_name in flatten([
      for res in var.role_assignments : [
        for name in res.resource_names :
        name if res.resource_type == "service_bus"
      ]
    ]) : resource_name => resource_name 
  }

  name                = each.key
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "example" {
  for_each = { 
    for value in local.flattened_role_assignments : 
    "${value.resource_name}_${value.role_definition_name}" => value 
  }

  scope                = lookup(local.resource_id_map, each.value.resource_name, null)
  role_definition_name = each.value.role_definition_name
  principal_id         = azurerm_user_assigned_identity.example.principal_id
}