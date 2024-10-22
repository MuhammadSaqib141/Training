resource "azurerm_ssh_public_key" "mysshkey" {
  name                = "my_ssh_key"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  public_key          = file("/home/muhammad/.ssh/my_ssh_key.pub")
}


resource "azurerm_public_ip" "wordpress_public_ip" {
  name                = "public_ip"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "linuxvm_nic" {
  for_each            = { for nic in var.network_interfaces : nic.name => nic } 

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = each.value.has_public_ip ? azurerm_public_ip.wordpress_public_ip.id : null
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each = { for vm in var.linux_vms : vm.name => vm }  

  name                              = each.value.name
  resource_group_name               = var.resource_group_name
  location                          = var.resource_group_location
  size                              = each.value.size
  admin_username                    = each.value.admin_username
  admin_password                    = each.value.admin_password
  disable_password_authentication    = each.value.disable_password_authentication
  network_interface_ids             = [for nic_name in each.value.network_interface_names : azurerm_network_interface.linuxvm_nic[nic_name].id]

  os_disk {
    caching              = each.value.os_disk_caching
    storage_account_type = each.value.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher
    offer     = each.value.source_image_reference.offer
    sku       = each.value.source_image_reference.sku
    version   = each.value.source_image_reference.version
  }

  custom_data = filebase64(each.value.custom_data_file)
}


resource "azurerm_linux_virtual_machine_scale_set" "scale_set" {
  name                = var.vmss_config.name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = var.vmss_config.sku
  instances           = var.vmss_config.instance_count
  admin_username      = var.vmss_config.admin_username

  

  admin_ssh_key {
    username   = var.vmss_config.admin_username
    public_key = azurerm_ssh_public_key.mysshkey.public_key
  }

  source_image_reference {
    publisher = var.vmss_config.source_image_reference.publisher
    offer     = var.vmss_config.source_image_reference.offer
    sku       = var.vmss_config.source_image_reference.sku
    version   = var.vmss_config.source_image_reference.version
  }

  os_disk {
    storage_account_type = var.vmss_config.os_disk.storage_account_type
    caching              = var.vmss_config.os_disk.caching
  }

  network_interface {
    name    = var.vmss_config.nic_name
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.vmss_config.subnet_id
    }
  }
  custom_data = filebase64("/home/muhammad/Training/8_terraform/3_cloud_init/wordpress.yml")
  
}






