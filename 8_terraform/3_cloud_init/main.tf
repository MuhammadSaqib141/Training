resource "azurerm_resource_group" "saqib_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "saqib_vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.saqib_rg.name
  location            = azurerm_resource_group.saqib_rg.location
  address_space       = var.address_space

  depends_on = [azurerm_resource_group.saqib_rg]
}

resource "azurerm_subnet" "saqib_vnet_subnetA" {
  name                 = var.saqib_vnet_subnetA
  resource_group_name  = azurerm_resource_group.saqib_rg.name
  virtual_network_name = azurerm_virtual_network.saqib_vnet.name
  address_prefixes     = ["10.0.0.0/24"]

  depends_on = [azurerm_virtual_network.saqib_vnet]
}

resource "azurerm_subnet" "saqib_vnet_subnetB" {
  name                 = var.saqib_vnet_subnetB
  resource_group_name  = azurerm_resource_group.saqib_rg.name
  virtual_network_name = azurerm_virtual_network.saqib_vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  depends_on = [azurerm_virtual_network.saqib_vnet]
}

resource "azurerm_network_security_group" "test_nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = azurerm_resource_group.saqib_rg.name

  depends_on = [azurerm_resource_group.saqib_rg]
}

resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "Allow-SSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.test_nsg.name
  resource_group_name         = azurerm_resource_group.saqib_rg.name

  depends_on = [azurerm_network_security_group.test_nsg]
}

resource "azurerm_network_security_rule" "allow_http" {
  name                        = "Allow-HTTP"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix   = "*"
  network_security_group_name = azurerm_network_security_group.test_nsg.name
  resource_group_name         = azurerm_resource_group.saqib_rg.name

  depends_on = [azurerm_network_security_group.test_nsg]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "public_ip"
  resource_group_name = azurerm_resource_group.saqib_rg.name
  location            = azurerm_resource_group.saqib_rg.location
  allocation_method   = "Static"

  depends_on = [azurerm_resource_group.saqib_rg]
}

resource "azurerm_network_interface" "linuxvm_nic" {
  name                = "linuxvm_nic"
  location            = azurerm_resource_group.saqib_rg.location
  resource_group_name = azurerm_resource_group.saqib_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.saqib_vnet_subnetB.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }

  depends_on = [
    azurerm_subnet.saqib_vnet_subnetB,
    azurerm_public_ip.public_ip,
    azurerm_network_security_group.test_nsg
  ]
}

resource "azurerm_network_interface_security_group_association" "azurerm_network_interface_security_group_association" {
  network_interface_id      = azurerm_network_interface.linuxvm_nic.id
  network_security_group_id = azurerm_network_security_group.test_nsg.id

  depends_on = [
    azurerm_network_interface.linuxvm_nic,
    azurerm_network_security_group.test_nsg
  ]
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = "test-machine"
  resource_group_name = azurerm_resource_group.saqib_rg.name
  location            = azurerm_resource_group.saqib_rg.location
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.linuxvm_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = filebase64("/home/muhammad/Training/8_terraform/3_cloud_init/wordpress.yml")

  depends_on = [
    azurerm_network_interface.linuxvm_nic,
    azurerm_public_ip.public_ip,
    azurerm_network_security_group.test_nsg
  ]
}
