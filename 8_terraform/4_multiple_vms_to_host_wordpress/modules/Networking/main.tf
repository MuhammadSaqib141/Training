
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

resource "azurerm_network_security_group" "nsg" {
  for_each            = { for idx, nsg in var.nsgs : idx => nsg }
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
  for_each = { for idx, single_ass in var.association_nsg_subnets : idx => single_ass }
  subnet_id                 = each.value.subnet_id
  network_security_group_id = each.value.nsg_id
}


