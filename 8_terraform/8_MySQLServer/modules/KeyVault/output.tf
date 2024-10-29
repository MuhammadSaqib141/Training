output "secrets" {
  value = { for key, secret in data.azurerm_key_vault_secret.this : key => secret.value }
  sensitive = true 
}