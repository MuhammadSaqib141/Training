


output "subnet_ids" {
  description = "The IDs of the created subnets"
  value = {
    for idx, subnet in azurerm_subnet.saqib_vnet_subnets : idx => subnet.id
  }
}


output "nsgs_ids" {
  description = "The IDs of the created subnets"
  value = {
    for idx, nsg in azurerm_network_security_group.wordpress_nsg : idx => nsg.id
  }
}