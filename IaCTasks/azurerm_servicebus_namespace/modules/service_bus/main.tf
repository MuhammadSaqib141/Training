resource "azurerm_servicebus_namespace" "example" {
  name                = var.servicebus.servicebus_namespace.name
  location            = var.servicebus.resource_group_location
  resource_group_name = var.servicebus.resource_group_name
  sku                 = var.servicebus.servicebus_namespace.sku
  local_auth_enabled  = var.servicebus.servicebus_namespace.local_auth_enabled
  public_network_access_enabled = var.servicebus.network_rule_set != null ? var.servicebus.network_rule_set.public_network_access_enabled : true
  minimum_tls_version = var.servicebus.servicebus_namespace.minimum_tls_version
  capacity = var.servicebus.servicebus_namespace.sku == "Premium" ? var.servicebus.servicebus_namespace.capacity : 0
  premium_messaging_partitions  = var.servicebus.servicebus_namespace.sku == "Premium" ? var.servicebus.servicebus_namespace.premium_messaging_partitions : 0

  dynamic "identity" {
    for_each = var.servicebus.servicebus_namespace.identity != null ? [1] : []
    content {
      type         = var.servicebus.servicebus_namespace.identity.type
      identity_ids = var.servicebus.servicebus_namespace.identity.type == "UserAssigned" ? var.servicebus.servicebus_namespace.identity.identity_ids : []
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.servicebus.customer_managed_key != null ? [var.servicebus.customer_managed_key] : []
    content {
      key_vault_key_id                  = var.servicebus.customer_managed_key.key_vault_key_id
      identity_id                       = var.servicebus.customer_managed_key.identity_id
      infrastructure_encryption_enabled = var.servicebus.customer_managed_key.infrastructure_encryption_enabled
    }
  }

  dynamic "network_rule_set" {
    for_each = var.servicebus.network_rule_set != null ? [1] : []
    content {
      default_action                = var.servicebus.network_rule_set.default_action
      trusted_services_allowed      = var.servicebus.network_rule_set.trusted_services_allowed
      public_network_access_enabled = var.servicebus.network_rule_set.public_network_access_enabled
      ip_rules                      = var.servicebus.network_rule_set.ip_rules

      dynamic "network_rules" {
        for_each = var.servicebus.network_rule_set.network_rules != null ? var.servicebus.network_rule_set.network_rules : []
        content {
          subnet_id                        = network_rule.value.subnet_id
          ignore_missing_vnet_service_endpoint = lookup(network_rule.value, "ignore_missing_vnet_service_endpoint", false)
        }
      }
    }
  }

  tags = var.servicebus.tags
}


resource "azurerm_servicebus_topic" "example" {
  for_each = var.servicebus_topics

  name                           = each.value.name
  namespace_id                   = azurerm_servicebus_namespace.example.id
  status                         = each.value.status
  auto_delete_on_idle            = each.value.auto_delete_on_idle
  default_message_ttl            = each.value.default_message_ttl
  duplicate_detection_history_time_window = each.value.duplicate_detection_history_time_window
  batched_operations_enabled     = each.value.batched_operations_enabled
  express_enabled                = each.value.express_enabled
  partitioning_enabled           = each.value.partitioning_enabled
  max_message_size_in_kilobytes  = each.value.max_message_size_in_kilobytes
  max_size_in_megabytes          = each.value.max_size_in_megabytes
  requires_duplicate_detection   = each.value.requires_duplicate_detection
  support_ordering               = each.value.support_ordering
}



# resource "azurerm_servicebus_subscription" "servicebus_subscription" {
#   name     = "tfex_servicebus_subscription"
#   topic_id = azurerm_servicebus_topic.example[each.key]
#   max_delivery_count = 1

# }