
resource_group_name    = "test-resource-group"
resource_group_location = "North Europe"


servicebus_config = {
  bus1 = {
    servicebus_namespace = {
      name                        = "saqib-bus1-namespace"
      sku                         = "Standard"
      minimum_tls_version         = "1.2"
      public_network_access_enabled = true
      local_auth_enabled          = true
      identity                    = null
      capacity                    = 2
      premium_messaging_partitions = 0
      customer_managed_key = null
      network_rule_set = null
      tags = {
        environment = "dev"
      }
    }

    servicebus_topics = {
      example_topic_1 = {
        name                              = "topic-1"
        status                            = "Active"
        auto_delete_on_idle               = "P10675199DT2H48M5.4775807S"
        default_message_ttl               = "P10675199DT2H48M5.4775807S"
        duplicate_detection_history_time_window = "PT10M"
        batched_operations_enabled        = true
        express_enabled                   = false
        partitioning_enabled              = true
        max_message_size_in_kilobytes     = 1024
        max_size_in_megabytes             = 5120
        requires_duplicate_detection      = true
        support_ordering                  = false
        client_scoped_subscription = null
        subcriptions = {
          sub1 = {
            name                              = "sub-1"
            max_delivery_count                = 10
            auto_delete_on_idle               = "P10675199DT2H48M5.4775807S"
            default_message_ttl               = "P10675199DT2H48M5.4775807S"
            lock_duration                     = "PT1M"
            dead_lettering_on_message_expiration = false
            dead_lettering_on_filter_evaluation_error = true
            batched_operations_enabled        = false
            requires_session                  = false
            forward_to                        = null
            forward_dead_lettered_messages_to = null
            status                            = "Active"
            client_scoped_subscription_enabled = false
            client_scoped_subscription = null
          }
        }
      },
      example_topic_2 = {
        name                              = "topic-2"
        status                            = "Active"
        auto_delete_on_idle               = "P10675199DT2H48M5.4775807S"
        default_message_ttl               = "P10675199DT2H48M5.4775807S"
        duplicate_detection_history_time_window = "PT10M"
        batched_operations_enabled        = true
        express_enabled                   = false
        partitioning_enabled              = false
        max_message_size_in_kilobytes     = 1024
        max_size_in_megabytes             = 5120
        requires_duplicate_detection      = false
        support_ordering                  = true
        subcriptions = {
          sub2 = {
            name                              = "sub-2"
            max_delivery_count                = 15
            auto_delete_on_idle               = "P10675199DT2H48M5.4775807S"
            default_message_ttl               = "P10675199DT2H48M5.4775807S"
            lock_duration                     = "PT2M"
            dead_lettering_on_message_expiration = false
            dead_lettering_on_filter_evaluation_error = true
            batched_operations_enabled        = false
            requires_session                  = false
            forward_to                        = null
            forward_dead_lettered_messages_to = null
            status                            = "Active"
            client_scoped_subscription_enabled = false
            client_scoped_subscription = null

          }
        }
      }
    }

    servicebus_queues = {
      example_queue_1 = {
        name                            = "queue-1"
        lock_duration                   = "PT2M"
        max_message_size_in_kilobytes   = 1024
        max_size_in_megabytes           = 2048
        requires_duplicate_detection    = true
        requires_session                = false
        default_message_ttl             = "P10675199DT2H48M5.4775807S"
        dead_lettering_on_message_expiration = false
        duplicate_detection_history_time_window = "PT10M"
        max_delivery_count              = 10
        status                          = "Active"
        batched_operations_enabled      = true
        auto_delete_on_idle             = "P10675199DT2H48M5.4775807S"
        partitioning_enabled            = false
        express_enabled                 = false
        forward_to                      = null
        forward_dead_lettered_messages_to = null
      }
    }
  }
}


