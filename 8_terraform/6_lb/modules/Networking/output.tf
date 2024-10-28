
output "wordpress_subnet_id" {
  description = "The IDs of the created subnets"
  value = azurerm_subnet.subnet["subnet1"].id
}

output "db_subnet_id" {
  description = "The IDs of the created subnets"
  value = azurerm_subnet.subnet["subnet2"].id
}


output "subnets" {
  value = azurerm_subnet.subnet
}

output "nsgs" {
  value = azurerm_network_security_group.nsg
}

output "PublicIPAddressForLB" {
  value = azurerm_public_ip.public_ips["PublicIPAddressForLB"].id
}