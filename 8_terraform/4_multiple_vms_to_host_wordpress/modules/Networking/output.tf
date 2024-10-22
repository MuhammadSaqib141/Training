
output "wordpress_subnet_id" {
  description = "The IDs of the created subnets"
  value = azurerm_subnet.saqib_vnet_subnets["subnet1"].id
}

output "db_subnet_id" {
  description = "The IDs of the created subnets"
  value = azurerm_subnet.saqib_vnet_subnets["subnet2"].id
}

# output "subnet_ids" {
#   value = { for name, subnet in azurerm_subnet.saqib_vnet_subnets : name => subnet.id }
# }

# output "nsg_ids" {
#   value = { for name, nsg in azurerm_network_security_group.nsg : name => nsg.id }
# }

# output "subnets" {
#   value = { for subnet in azurerm_subnet.saqib_vnet_subnets : subnet.name => {
#       id                     = subnet.id
#       name                   = subnet.name
#       address_prefixes       = subnet.address_prefixes
#       virtual_network_name   = subnet.virtual_network_name
#       resource_group_name    = var.resource_group_name
#     }
#   }
# }

output "subnets" {
  value = azurerm_subnet.saqib_vnet_subnets
}

output "nsgs" {
  value = azurerm_network_security_group.nsg
}