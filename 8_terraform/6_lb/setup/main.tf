
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

module "networking" {
  source                  = "../modules/Networking"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  virtual_networks        = var.virtual_networks
  nsgs = var.nsgs
  public_ips  = var.public_ips
  nat_gateways = var.nat_gateways
  depends_on = [ azurerm_resource_group.resource_group ]
}


module "virtualmachines" {
  source = "../modules/VirtualMachine"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  network_interfaces = local.network_interfaces
  linux_vms = var.linux_vms


  depends_on = [ module.networking ]
}



# module "loadbalancer" {
#   source = "../modules/LoadBalancer"
#   resource_group_name     = var.resource_group_name
#   resource_group_location = var.resource_group_location
#   lb_config = local.lb_config
#   vmss_config = local.vmss_config
#   depends_on = [ module.virtualmachines ]
# }