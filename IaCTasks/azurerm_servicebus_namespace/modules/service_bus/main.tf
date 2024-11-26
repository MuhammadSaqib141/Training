
resource "azurerm_servicebus_namespace" "example" {
  name                = var.servicebus.name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = var.servicebus.sku
  local_auth_enabled  = var.servicebus.local_auth_enabled
  public_network_access_enabled = var.servicebus.network_rule_set != null ? var.servicebus.network_rule_set.public_network_access_enabled : true
  minimum_tls_version = var.servicebus.minimum_tls_version
  capacity = var.servicebus.sku == "Premium" ? var.servicebus.capacity : 0
  premium_messaging_partitions  = var.servicebus.sku == "Premium" ? var.servicebus.premium_messaging_partitions : 0

  dynamic "identity" {
    for_each = var.servicebus.identity != null ? [1] : []
    content {
      type         = var.servicebus.identity.type
      identity_ids = var.servicebus.identity.type == "UserAssigned" ? var.servicebus.identity.identity_ids : []
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
  name                           =  "${azurerm_servicebus_namespace.example.name}-${each.value.name}" 
  namespace_id                   = azurerm_servicebus_namespace.example.id
  status                         = each.value.status
  auto_delete_on_idle            = each.value.auto_delete_on_idle
  default_message_ttl            = each.value.default_message_ttl
  duplicate_detection_history_time_window = each.value.duplicate_detection_history_time_window
  batched_operations_enabled     = each.value.batched_operations_enabled
  express_enabled                = each.value.express_enabled
  partitioning_enabled           = each.value.partitioning_enabled
  max_message_size_in_kilobytes  = azurerm_servicebus_namespace.example.sku == "Premium" ? each.value.max_message_size_in_kilobytes : null
  max_size_in_megabytes          = azurerm_servicebus_namespace.example.sku == "Premium" ? each.value.max_size_in_megabytes : null
  requires_duplicate_detection   = each.value.requires_duplicate_detection
  support_ordering               = each.value.support_ordering
}

resource "azurerm_servicebus_queue" "example" {
  for_each = var.servicebus_queues
  name     = "${azurerm_servicebus_namespace.example.name}-${each.value.name}"
  namespace_id = azurerm_servicebus_namespace.example.id

  lock_duration                      = each.value.lock_duration
  requires_duplicate_detection       = each.value.requires_duplicate_detection
  requires_session                   = each.value.requires_session
  default_message_ttl                = each.value.default_message_ttl
  dead_lettering_on_message_expiration = each.value.dead_lettering_on_message_expiration
  duplicate_detection_history_time_window = each.value.duplicate_detection_history_time_window
  max_delivery_count                 = each.value.max_delivery_count
  status                             = each.value.status
  batched_operations_enabled         = each.value.batched_operations_enabled
  auto_delete_on_idle                = each.value.auto_delete_on_idle
  partitioning_enabled               = each.value.partitioning_enabled
  express_enabled                    = each.value.express_enabled
  forward_to                         = each.value.forward_to
  forward_dead_lettered_messages_to = each.value.forward_dead_lettered_messages_to
  max_message_size_in_kilobytes = azurerm_servicebus_namespace.example.sku == "Premium" ? each.value.max_message_size_in_kilobytes : null
  max_size_in_megabytes = azurerm_servicebus_namespace.example.sku == "Premium" ? each.value.max_size_in_megabytes : null
}

resource "azurerm_servicebus_subscription" "example" {
  for_each = local.subscriptions_map

  name                              = "${azurerm_servicebus_topic.example[each.value.topic_key].name}-${each.value.subscription.name}"
  topic_id                          = azurerm_servicebus_topic.example[each.value.topic_key].id
  max_delivery_count                = each.value.subscription.max_delivery_count
  auto_delete_on_idle               = each.value.subscription.auto_delete_on_idle
  default_message_ttl               = each.value.subscription.default_message_ttl
  lock_duration                     = each.value.subscription.lock_duration
  dead_lettering_on_message_expiration = each.value.subscription.dead_lettering_on_message_expiration
  dead_lettering_on_filter_evaluation_error = each.value.subscription.dead_lettering_on_filter_evaluation_error
  batched_operations_enabled        = each.value.subscription.batched_operations_enabled
  requires_session                  = each.value.subscription.requires_session
  forward_to                        = each.value.subscription.forward_to
  forward_dead_lettered_messages_to = each.value.subscription.forward_dead_lettered_messages_to
  status                            = each.value.subscription.status
  client_scoped_subscription_enabled = each.value.subscription.client_scoped_subscription_enabled

  dynamic "client_scoped_subscription" {
    for_each = each.value.subscription.client_scoped_subscription_enabled ? [1] : []
    content {
      client_id = each.value.subscription.client_scoped_subscription.client_id
      is_client_scoped_subscription_shareable = each.value.subscription.client_scoped_subscription.is_client_scoped_subscription_shareable
      is_client_scoped_subscription_durable  = each.value.subscription.client_scoped_subscription.is_client_scoped_subscription_durable
    }
  }
}