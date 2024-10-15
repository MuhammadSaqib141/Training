# main.tf
resource "azurerm_resource_group" "saqib_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "saqib_vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.saqib_rg.name
  location            = azurerm_resource_group.saqib_rg.location
  address_space       = var.address_space
}

resource "azurerm_subnet" "saqib_vnet_subnetA" {
  name                 = "subnetA" //
  resource_group_name  = azurerm_resource_group.saqib_rg.name
  virtual_network_name = azurerm_virtual_network.saqib_vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "saqib_vnet_subnetB" {
  name                 = "subnetB"
  resource_group_name  = azurerm_resource_group.saqib_rg.name
  virtual_network_name = azurerm_virtual_network.saqib_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "test_nsg" {
  name                = "test-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.saqib_rg.name
}

resource "azurerm_network_security_rule" "test_rule1" {
  name                        = "rule1"
  priority                    = 1000
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.saqib_rg.name
  network_security_group_name = azurerm_network_security_group.test_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.saqib_vnet_subnetB.id
  network_security_group_id = azurerm_network_security_group.test_nsg.id
}