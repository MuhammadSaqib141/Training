resource "azurerm_user_assigned_identity" "example" {
  location            = var.resource_group_location
  name                = var.user_identity_name
  resource_group_name = var.resource_group_name
}

output "identity" {
  value = azurerm_user_assigned_identity.example
}

# Data source to retrieve storage accounts by name, filtering only for storage_account resources
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

# Data source to retrieve service bus namespaces by name, filtering only for service_bus resources
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

output "accounts" {
  value = data.azurerm_storage_account.storage_account
}

output "service_buses" {
  value = data.azurerm_servicebus_namespace.service_bus_namespace
}

locals {
  # Flattened list of all role assignments, pairing each resource with role definitions
  flattened_role_assignments = flatten([
    for res in var.role_assignments : [
      for name in res.resource_names : [
        for role in res.role_definition_list : {
          resource_name        = name
          role_definition_name = role
        }
      ]
    ]
  ])

  # Mapping each resource name to its ID, handling both storage accounts and service bus namespaces
  resource_id_map = {
    for resource in flatten([
      for assignment in var.role_assignments : [
        for resource_name in assignment.resource_names : {
          name = resource_name
          id   = (
            assignment.resource_type == "storage_account" ? 
                    data.azurerm_storage_account.storage_account[resource_name].id :
                assignment.resource_type == "service_bus"  ? 
                    data.azurerm_servicebus_namespace.service_bus_namespace[resource_name].id
                : null)
        }
      ]
    ]) : resource.name => resource.id if resource.id != null
  }
}

output "flattened_role_assignments" {
  value = local.flattened_role_assignments
}

output "resource_id_map" {
  value = local.resource_id_map
}

# Resource block for creating role assignments for specified resources
resource "azurerm_role_assignment" "example" {
  for_each = { 
    for value in local.flattened_role_assignments : 
    "${value.resource_name}_${value.role_definition_name}" => value 
  }

  scope                = lookup(local.resource_id_map, each.value.resource_name, null)
  role_definition_name = each.value.role_definition_name
  principal_id         = azurerm_user_assigned_identity.example.principal_id
}
