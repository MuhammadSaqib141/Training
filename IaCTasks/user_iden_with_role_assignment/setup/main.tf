
data "azurerm_resource_group" "rg" {
    name = "saqib-rg"
}


module "user_identities_with_role_assignments" {

    source = "../modules/user_identities_with_role_assignments"
    for_each = var.managed_identities

    resource_group_name = data.azurerm_resource_group.rg.name
    resource_group_location = data.azurerm_resource_group.rg.location
    user_identity_name = each.value.user_identity_name
    role_assignments = each.value.role_assignments

    depends_on = [ data.azurerm_resource_group.rg ]
}


locals {
    managed_identitiy_ids = { for key, value in module.user_identities_with_role_assignments: key => value.identity.id }
}

resource "azurerm_storage_account" "example" {
  name                     = "randomaccountstorafe"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "example" {
  name                = "example-test-service-plan"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_function_app" "example" {
  name                = "example-test-function-app"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location

  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  service_plan_id            = azurerm_service_plan.example.id

  identity {
    type = "UserAssigned"
    identity_ids = [local.managed_identitiy_ids["identity001"]]
  }

  site_config {}
}