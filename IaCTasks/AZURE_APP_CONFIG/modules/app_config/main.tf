locals {
  identity_type = join(", ", compact([
    var.app_configuration.system_assigned_identity_enabled ? "SystemAssigned" : "",
    length(var.app_configuration.identity_ids) > 0 ? "UserAssigned" : ""
  ]))
}

resource "azurerm_app_configuration" "this" {
  name                       = var.app_configuration.name
  resource_group_name        = var.resource_group_name
  location                   = var.resource_group_location
  sku                        = var.app_configuration.sku
  local_auth_enabled         = var.app_configuration.local_auth_enabled
  public_network_access      = var.app_configuration.public_network_access
  purge_protection_enabled   = var.app_configuration.purge_protection_enabled
  soft_delete_retention_days = var.app_configuration.soft_delete_retention_days

  dynamic "identity" {
    for_each = local.identity_type != "" ? [0] : []
    content {
        type        = local.identity_type
        identity_ids = var.app_configuration.identity_ids
    }
  }

  dynamic "encryption" {
    for_each = var.app_configuration.encryption != null ? [0] : []
    content {
        key_vault_key_identifier = var.app_configuration.encryption.key_vault_key_identifier
        identity_client_id       = var.app_configuration.encryption.identity_client_id
    }
  }

  dynamic "replica" {
    for_each = var.app_configuration.replica
    content {
        name     = replica.value.name
        location = replica.value.location
    }
  }

  tags = var.app_configuration.tags

}
