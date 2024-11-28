variable "resource_group_name" {
    description = "The name of the resource group in which to create the App Configuration."
    type        = string
}

variable "resource_group_location" {
    description = "The Azure region where the resource group resides."
    type        = string
}

variable "app_configuration" {
    description = "Configuration object for the Azure App Configuration resource."
    type = object({
        name                       = string
        sku                        = string
        local_auth_enabled         = optional(bool, true) 
        public_network_access      = optional(string, "Enabled") 
        purge_protection_enabled   = optional(bool, false) 
        soft_delete_retention_days = optional(number, 7) 
        system_assigned_identity_enabled = optional(bool, false) 
        identity_ids               = optional(list(string), []) 
        tags                       = optional(map(string), {}) 

        replica = optional(list(object({
          name     = string
          location = string
        })), []) 

        encryption = optional(object({
          key_vault_key_identifier = optional(string)
          identity_client_id       = optional(string)
        }), null) 
    })
}
