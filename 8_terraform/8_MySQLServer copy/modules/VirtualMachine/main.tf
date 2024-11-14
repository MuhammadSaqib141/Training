
resource "azurerm_network_interface" "linuxvm_nic" {
  name                = var.network_interface.name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.network_interface.has_public_ip ? var.public_ip : null
  }
}



resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                              = var.linux_vm.name
  resource_group_name               = var.resource_group_name
  location                          = var.resource_group_location
  size                              = var.linux_vm.size
  admin_username                    = var.linux_vm.admin_username
  admin_password                    =  var.secrets["vm_password"]
  disable_password_authentication   = var.linux_vm.disable_password_authentication
  network_interface_ids             = [azurerm_network_interface.linuxvm_nic.id]

  os_disk {
    caching              = var.linux_vm.os_disk_caching
    storage_account_type = var.linux_vm.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.linux_vm.source_image_reference.publisher
    offer     = var.linux_vm.source_image_reference.offer
    sku       = var.linux_vm.source_image_reference.sku
    version   = var.linux_vm.source_image_reference.version
  }

  custom_data = base64encode(templatefile("${path.module}/wordpress.tpl", {
    database_name     = var.database_name
    database_user     = var.database_user
    database_password = var.database_password
    database_host     = var.database_host
  }))
}