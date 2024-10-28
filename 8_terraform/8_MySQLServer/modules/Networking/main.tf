resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network.name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = var.virtual_network.address_space
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_public_ip" "public_ip" {
  for_each = var.public_ips  

  name                = each.value.name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = each.value.allocation_method
}


resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg.name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.nsg.rules
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
    for subnet_key, subnet_value in var.subnets :
    subnet_key => subnet_value
    if contains(keys(var.subnets[subnet_key]), "nsg_association") && var.subnets[subnet_key].nsg_association != null
  }

  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
