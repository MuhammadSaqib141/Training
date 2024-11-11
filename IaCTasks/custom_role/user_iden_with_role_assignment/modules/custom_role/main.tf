data "azurerm_resource_group" "name" {
  name = var.resource_group_name
  
}

resource "azurerm_role_definition" "custom_role" {
  name        = var.role_definition.name
  scope       = var.role_definition.scope
  description = var.role_definition.description

  permissions {
    actions          = var.role_definition.permissions.actions
    not_actions      = var.role_definition.permissions.not_actions
    data_actions     = var.role_definition.permissions.data_actions
    not_data_actions = var.role_definition.permissions.not_data_actions
  }

  assignable_scopes = var.role_definition.assignable_scopes
}

resource "azurerm_user_assigned_identity" "example" {
  location            = var.location
  name                = var.user_assigned_identity.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_assignment" "example" {
  scope                = data.azurerm_resource_group.name.id
  role_definition_name = azurerm_role_definition.custom_role.name
  principal_id         = azurerm_user_assigned_identity.example.principal_id
}
