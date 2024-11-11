data "azurerm_resource_group" "rg" {
  name = "saqib-rg"
}

locals {
  assignable_scopes = [data.azurerm_resource_group.rg.id]
}

module "custom_role" {
  source = "../modules/custom_role"


  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  role_definition = {
    name        = var.role_definition.name
    scope       = data.azurerm_resource_group.rg.id
    description = var.role_definition.description
    permissions = {
      actions          = var.role_definition.permissions.actions
      not_actions      = var.role_definition.permissions.not_actions
      data_actions     = var.role_definition.permissions.data_actions
      not_data_actions = var.role_definition.permissions.not_data_actions
    }
    assignable_scopes = [data.azurerm_resource_group.rg.id]
  }

  user_assigned_identity = {
    name                = var.user_assigned_identity.name
    location            = data.azurerm_resource_group.rg.location
    resource_group_name = data.azurerm_resource_group.rg.name
  }

}

