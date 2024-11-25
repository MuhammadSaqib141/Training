
variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "servicebus" {
  description = "Service Bus configuration"
  type = object({
    resource_group_name         = string
    resource_group_location     = string
    servicebus_namespace = object({
      name                    = string
      sku                     = string  
      minimum_tls_version     = optional(string, "1.2")  
      public_network_access_enabled = optional(bool, true)
      local_auth_enabled      = optional(bool, true)
      identity = optional(object({
        type         = string  
        identity_ids = optional(list(string), [])  
      }), null)
      capacity                = optional(number, null)  
      premium_messaging_partitions = optional(number , null)
    })
    customer_managed_key     = optional(object({
      key_vault_key_id                  = string
      identity_id                       = optional(string, null)
      infrastructure_encryption_enabled = optional(bool, false)
    }), null)
    network_rule_set         = optional(object({
      default_action                = string 
      trusted_services_allowed      = optional(bool, true)
      public_network_access_enabled = optional(bool, true)
      ip_rules                      = optional(list(string), [])
      network_rules = optional(list(object({
        subnet_id                        = string
        ignore_missing_vnet_service_endpoint = optional(bool, false)
      })), [])
    }), null)
    tags                     = map(string)
  })
}
