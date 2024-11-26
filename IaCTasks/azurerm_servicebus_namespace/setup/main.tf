

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.resource_group_location
}



module "servicebus" {
  for_each = var.servicebus_config

  source                  = "../modules/service_bus"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location

  servicebus        = each.value.servicebus_namespace
  servicebus_topics = each.value.servicebus_topics
  servicebus_queues = each.value.servicebus_queues

  depends_on = [azurerm_resource_group.example]
}



# module.servicebus