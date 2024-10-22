
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

module "networking" {
  source                  = "../modules/Networking"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  virtual_networks        = var.virtual_networks
  subnets                 = var.subnets
  nsgs                    = var.nsgs
  depends_on = [ azurerm_resource_group.resource_group ]
}

module "virtual_machines" {
  source                  = "../modules/VirtualMachine"
  resource_group_name     = azurerm_resource_group.resource_group.name  
  resource_group_location = var.resource_group_location
  network_interfaces = local.network_interfaces
  # association_nic_nsg = local.association_nic_nsg
  linux_vms = var.linux_vms
  
  depends_on = [ module.networking ]
}