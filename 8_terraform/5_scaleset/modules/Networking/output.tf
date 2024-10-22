
output "wordpress_subnet_id" {
  description = "The IDs of the created subnets"
  value = azurerm_subnet.saqib_vnet_subnets["subnet1"].id
}

output "db_subnet_id" {
  description = "The IDs of the created subnets"
  value = azurerm_subnet.saqib_vnet_subnets["subnet2"].id
}


output "subnets" {
  value = azurerm_subnet.saqib_vnet_subnets
}

output "nsgs" {
  value = azurerm_network_security_group.nsg
}