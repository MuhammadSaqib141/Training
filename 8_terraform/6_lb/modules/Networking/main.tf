
# Create the virtual network
resource "azurerm_virtual_network" "vnet" {
  for_each = var.virtual_networks

  name                = each.value.name
  location            = each.value.location
  resource_group_name = var.resource_group_name 
  address_space       = each.value.address_space
}

resource "azurerm_subnet" "subnet" {
  for_each = { for  subnet_value in flatten([
    for vnet_key, vnet_value in var.virtual_networks :
    [for subnet in vnet_value.subnet_configs : merge(subnet, { virtual_network_key = vnet_key })]
  ]) : subnet_value.name => subnet_value }

  name                 = each.value.name
  resource_group_name  = var.resource_group_name  
  virtual_network_name = azurerm_virtual_network.vnet[each.value.virtual_network_key].name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nsgs
  name                = each.value.name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
 
  dynamic "security_rule" {
    for_each = each.value.rules
    content {
      name                        = security_rule.value.name
      priority                    = security_rule.value.priority
      direction                   = security_rule.value.direction
      access                      = security_rule.value.access
      protocol                    = security_rule.value.protocol
      source_port_range           = security_rule.value.source_port_range
      destination_port_range      = security_rule.value.destination_port_range
      source_address_prefix       = security_rule.value.source_address_prefix
      destination_address_prefix  = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "association" {
  for_each = {
    for subnet in flatten([
      for vnet_value in var.virtual_networks : [
        for subnet_key, subnet_value in vnet_value.subnet_configs : subnet_value
      ]
    ]) :
    
    subnet.name => subnet.nsg_to_be_associated
    if subnet.nsg_to_be_associated != null && length(subnet.nsg_to_be_associated) > 0
  }

  subnet_id                 = azurerm_subnet.subnet[each.key].id  
  network_security_group_id  = azurerm_network_security_group.nsg[each.value].id
}

resource "azurerm_public_ip" "public_ips" {
  for_each = var.public_ips
  name                = each.value.name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}

resource "azurerm_nat_gateway" "example" {
  for_each = var.nat_gateways
  name                    = each.value.name
  location                = var.resource_group_location
  resource_group_name     = var.resource_group_name
  sku_name                = each.value.sku_name
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes
}

resource "azurerm_nat_gateway_public_ip_association" "nat_ip_association" {
  for_each = var.nat_gateways

  nat_gateway_id       = azurerm_nat_gateway.example[each.key].id  
  public_ip_address_id = azurerm_public_ip.public_ips[each.value.public_ips[0]].id
}


resource "azurerm_subnet_nat_gateway_association" "nat_gateway_association" {
  for_each = var.nat_gateways
  subnet_id      = azurerm_subnet.subnet[each.value.subnet_to_be_attached].id
  nat_gateway_id = azurerm_nat_gateway.example[each.key].id
}
