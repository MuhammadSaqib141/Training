
locals {
  servicebus_namespaces = [
    {
      resource_group_name    = "test-resource-group"
      resource_group_location = "North Europe"
      servicebus_namespace = {
        name                = "saqib-test-namespace-1"
        sku                 = "Standard"
        minimum_tls_version = "1.2"
        local_auth_enabled  = true
        identity = null
        capacity = 2
        premium_messaging_partitions = 0
      }

      customer_managed_key = null

      network_rule_set = null 

      tags = {
        environment = "dev"
      }

    }
  ]
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

module "servicebus" {
  source = "../modules/service_bus"
  resource_group_name = var.resource_group_name
  resource_group_location = var.resource_group_location
  servicebus = var.servicebus
}