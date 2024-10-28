
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


module "vms" {
  source = "../modules/VirtualMachine"
  for_each = var.vm_configs
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  subnet_id = module.networking["vnet1"].subnets[each.value.subnet_id]  
  public_ip = module.networking["vnet1"].public_ips[each.value.public_ip]
  linux_vm                = each.value.vm      
  network_interface       = each.value.nic     
  depends_on = [ module.networking ]
}

module "db" {
  for_each = var.networking_config

  source                  = "../modules/DB"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  mysql_config = var.mysql_config

  depends_on = [ azurerm_resource_group.resource_group  ]
}