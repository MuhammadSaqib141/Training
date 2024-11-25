servicebus = {
  resource_group_name    = "test-resource-group"
  resource_group_location = "North Europe"
  servicebus_namespace = {
    name                    = "saqib-nc-00001"
    sku                     = "Standard"
    minimum_tls_version     = "1.2"
    local_auth_enabled      = true
    identity                = null
    capacity                = 2
    premium_messaging_partitions = 0
  }
  customer_managed_key     = null
  network_rule_set         = null
  tags = {
    environment = "dev"
  }
}
  resource_group_name    = "test-resource-group"
  resource_group_location = "North Europe"
