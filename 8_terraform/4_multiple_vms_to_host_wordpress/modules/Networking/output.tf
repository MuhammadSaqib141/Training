


output "wordpress_subnet_id" {
  description = "The IDs of the created subnets"
  value = azurerm_subnet.saqib_vnet_subnets["0"]
}

output "db_subnet_id" {
  description = "The IDs of the created subnets"
  value = azurerm_subnet.saqib_vnet_subnets["1"]
}

output "wordpress_nsg_id" {
  description = "The IDs of the created subnets"
  value = azurerm_network_security_group.nsg["0"]
}

output "db_nsg_id" {
  description = "The IDs of the created subnets"
  value = azurerm_network_security_group.nsg["1"]
}