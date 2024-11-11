locals {
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


