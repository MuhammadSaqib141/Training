



resource "azurerm_public_ip" "wordpress_public_ip" {
  name                = "public_ip"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = "Static"
}


resource "azurerm_network_interface" "linuxvm_nic_with_public_ip" {
  name                = "${var.nic_name}"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_ids["0"]
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.wordpress_public_ip.id
  }
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
  admin_username      = "test_vm_so_far"
  admin_password      = "testing_vms@123"
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

  # custom_data = filebase64("/home/muhammad/Training/8_terraform/3_cloud_init/wordpress.yml")

  depends_on = [
    azurerm_network_interface.linuxvm_nic,
    azurerm_public_ip.public_ip,
    azurerm_network_security_group.test_nsg
  ]
}
