variable "resource_group_location" {
  type        = string
  description = "The location of the resource group where the Service Bus will be created."
}


variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the Service Bus will be created."
}

variable "servicebus" {
  description = "Configuration for the Service Bus namespace."
    type = object({

      name                        = string
      sku                         = string
      minimum_tls_version         = optional(string, "1.2")
      public_network_access_enabled = optional(bool, true)
      local_auth_enabled          = optional(bool, true)
      identity = optional(object({
        type         = string
        identity_ids = optional(list(string), [])
      }), null)
      capacity                    = optional(number, null)
      premium_messaging_partitions = optional(number, null)
      tags = optional(map(string), {})
      customer_managed_key = optional(object({
          key_vault_key_id                  = string
          identity_id                       = optional(string, null)
          infrastructure_encryption_enabled = optional(bool, false)
        }), null)

      network_rule_set = optional(object({
        default_action                = string
        trusted_services_allowed      = optional(bool, true)
        public_network_access_enabled = optional(bool, true)
        ip_rules                      = optional(list(string), [])
        network_rules = optional(list(object({
          subnet_id                        = string
          ignore_missing_vnet_service_endpoint = optional(bool, false)
        })), [])
      }), null)

    })

}

variable "servicebus_topics" {
  description = "Configuration for the Service Bus topics."
  type = map(object({
    name                              = string
    status                            = optional(string, "Active")
    auto_delete_on_idle               = optional(string, "P10675199DT2H48M5.4775807S")
    default_message_ttl               = optional(string, "P10675199DT2H48M5.4775807S")
    duplicate_detection_history_time_window = optional(string, "PT10M")
    batched_operations_enabled        = optional(bool, true)
    express_enabled                   = optional(bool, false)
    partitioning_enabled              = optional(bool, false)
    max_message_size_in_kilobytes     = optional(number, 1024)
    max_size_in_megabytes             = optional(number, 5120)
    requires_duplicate_detection      = optional(bool, false)
    support_ordering                  = optional(bool, false)
    subcriptions                      = optional(map(object({
      name                              = string
      max_delivery_count                = number
      auto_delete_on_idle               = optional(string, null)
      default_message_ttl               = optional(string, null)
      lock_duration                     = optional(string, "PT1M")
      dead_lettering_on_message_expiration = optional(bool, false)
      dead_lettering_on_filter_evaluation_error = optional(bool, true)
      batched_operations_enabled        = optional(bool, false)
      requires_session                  = optional(bool, false)
      forward_to                        = optional(string, null)
      forward_dead_lettered_messages_to = optional(string, null)
      status                            = optional(string, "Active")
      client_scoped_subscription_enabled = optional(bool, false)
      client_scoped_subscription         = optional(object({
        client_id                        = optional(string, null)
        is_client_scoped_subscription_shareable = optional(bool, true)
        is_client_scoped_subscription_durable = optional(bool, true)
      }), null)
    })), {})
  }))
}


variable "servicebus_queues" {
  description = "Map of Service Bus Queue configurations."
  type = map(object({
    name                            = string
    lock_duration                   = optional(string, "PT1M")
    max_message_size_in_kilobytes   = optional(number, null)
    max_size_in_megabytes           = optional(number, null)
    requires_duplicate_detection    = optional(bool, false)
    requires_session                = optional(bool, false)
    default_message_ttl             = optional(string, "P10675199DT2H48M5.4775807S")
    dead_lettering_on_message_expiration = optional(bool, false)
    duplicate_detection_history_time_window = optional(string, "PT10M")
    max_delivery_count              = optional(number, 10)
    status                          = optional(string, "Active")
    batched_operations_enabled      = optional(bool, true)
    auto_delete_on_idle             = optional(string, "P10675199DT2H48M5.4775807S")
    partitioning_enabled            = optional(bool, false)
    express_enabled                 = optional(bool, false)
    forward_to                      = optional(string, null)
    forward_dead_lettered_messages_to = optional(string, null)
  }))
}
