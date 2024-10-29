data "azurerm_client_config" "current" {
}

resource "azurerm_key_vault" "example" {
  name                        = var.key_vault_config.name
  location                    = var.resource_group_location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = var.key_vault_config.enabled_for_disk_encryption
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = var.key_vault_config.soft_delete_retention_days
  purge_protection_enabled    = var.key_vault_config.purge_protection_enabled
  sku_name                    = var.key_vault_config.sku_name

  dynamic "access_policy" {
    for_each = var.key_vault_config.access_policy
    content {
      tenant_id = data.azurerm_client_config.current.tenant_id
      object_id = data.azurerm_client_config.current.object_id
      key_permissions     = access_policy.value.key_permissions
      secret_permissions  = access_policy.value.secret_permissions
      storage_permissions = access_policy.value.storage_permissions
    }
  }
}

resource "azurerm_key_vault_secret" "this" {
  for_each    = var.secrets
  name        = each.value.name
  value       = each.value.value
  key_vault_id = azurerm_key_vault.example.id
}

resource "time_sleep" "wait_for_secret" {
  depends_on = [azurerm_key_vault_secret.this]
  create_duration = "10s"
}

data "azurerm_key_vault_secret" "this" {
  for_each     = var.secrets
  name         = each.value.name
  key_vault_id = azurerm_key_vault.example.id

  depends_on = [time_sleep.wait_for_secret]
}



