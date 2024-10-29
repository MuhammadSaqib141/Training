output "secrets" {
  value = { for key, secret in data.azurerm_key_vault_secret.this : key => secret.value }
  sensitive = true  # Prevents the value from being shown in the console
}