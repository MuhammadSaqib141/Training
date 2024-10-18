
# -------------------- Create VNets ------------------------------------------------!!!!

resource "azurerm_virtual_network" "saqib_vnet" {

  resource_group_name = var.resource_group_name
  for_each            = { for idx, vnet in var.virtual_networks : idx => vnet }
  name                = each.value.name
  location            = each.value.location
  address_space       = each.value.address_space
}

# -------------------- Create Subnets -------------------------------------------------!!!!

resource "azurerm_subnet" "saqib_vnet_subnets" {

  resource_group_name = var.resource_group_name

  for_each            = { for idx, subnet in var.subnets : idx => subnet }
  name                 = each.value.name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
  depends_on = [azurerm_virtual_network.saqib_vnet]
}

# -------------------- NSG & Rules -------------------------------------------------!!!!

resource "azurerm_network_security_group" "wordpress_nsg" {
  name                = "example-nsg"
  location            = "East US"
  resource_group_name = azurerm_resource_group.example_rg.name

  dynamic "security_rule" {
    for_each = var.each.rules
    content {
      name                        = security_rule.value.name
      priority                    = security_rule.value.priority
      direction                   = security_rule.value.direction
      access                      = security_rule.value.access
      protocol                    = security_rule.value.protocol
      source_port_range           = security_rule.value.source_port_range
      destination_port_range      = security_rule.value.destination_port_range
      source_address_prefix       = security_rule.value.source_address_prefix
      destination_address_prefix   = security_rule.value.destination_address_prefix
    }
  }
}



resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.saqib_vnet_subnets
  network_security_group_id = azurerm_network_security_group.samplensg.id
}