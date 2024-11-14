resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

module "networking" {
  for_each = var.networking_config

  source                  = "../modules/Networking"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  virtual_network         = each.value.virtual_network
  subnets                 = each.value.subnets
  public_ips              = each.value.public_ips
  nsg                     = each.value.nsg
  depends_on              = [azurerm_resource_group.resource_group]
}




