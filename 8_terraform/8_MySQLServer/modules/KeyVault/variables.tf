# Define a single object for the Key Vault configuration
variable "key_vault_config" {
  type = object({
    name                        = string
    location                    = string
    enabled_for_disk_encryption = bool
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool
    sku_name                    = string
    access_policy = list(object({
      tenant_id        = string
      object_id        = string
      key_permissions   = list(string)
      secret_permissions = list(string)
      storage_permissions = list(string)
    }))
  })

}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "The name of the resource location"
  type        = string
}

variable "secrets" {
  type = map(object({
    name  = string
    value = string
  }))
}