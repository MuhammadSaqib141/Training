variable "resource_group_location" {
  type = string
}

variable "resource_group_name" {
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




variable "servicebus_topics" {
  description = "Configuration for the ServiceBus Topic"
  type = map(object({
    name                              = string
    status                            = optional(string, "Active") # Default is Active
    auto_delete_on_idle               = optional(string, "P10675199DT2H48M5.4775807S")  # Default is 1 Day
    default_message_ttl               = optional(string, "P10675199DT2H48M5.4775807S")  # Default is 1 Hour
    duplicate_detection_history_time_window = optional(string, "PT10M")  # Default is 10 minutes
    batched_operations_enabled        = optional(bool, true) # Default is true
    express_enabled                   = optional(bool, false) # Default is false
    partitioning_enabled              = optional(bool, false) # Default is false
    max_message_size_in_kilobytes     = optional(number, 1024) # Default is 1MB
    max_size_in_megabytes             = optional(number, 5120) # Default is 5GB
    requires_duplicate_detection      = optional(bool, false) # Default is false
    support_ordering                  = optional(bool, false) # Default is false
  }))

  default = {
    "topic1" = {
          name                              = "example"
    } , 
    "topic2" = {
          name                              = "example"
    } 
  }
}

# variable "subscription_of_topic" {
  
# }
