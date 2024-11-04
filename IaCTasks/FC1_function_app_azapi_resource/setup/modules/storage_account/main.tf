resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication
}

output "storage_account_name" {
  value = azurerm_storage_account.example.name
}

output "storage_account_id" {
  value = azurerm_storage_account.example.id
}

output "storage_account_primary_access_key" {
  value = azurerm_storage_account.example.primary_access_key
}
