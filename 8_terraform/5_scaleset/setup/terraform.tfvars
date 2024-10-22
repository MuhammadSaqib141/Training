resource_group_name = "saqib-rg"

resource_group_location = "North Europe" 

virtual_networks = [
  {
    name          = "saqib-vnet"
    address_space = ["10.0.0.0/16"]
    location      = "North Europe"
  }
]

subnets = [
  {
    name                  = "subnet1"
    address_prefixes      = ["10.0.1.0/24"]
    virtual_network_name  = "saqib-vnet"
    nsg_to_be_associated  = null
  },
  {
    name                  = "subnet2"
    address_prefixes      = ["10.0.2.0/24"]
    virtual_network_name  = "saqib-vnet"
    nsg_to_be_associated  = "mysql-nsg"
  }
]

nsgs = [

  {
    name  = "mysql-nsg"
    rules = {
      "Allow-SSH" = {
        name                        = "Allow-SSH"
        priority                    = 1000
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "22"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
      },
      "Allow-MySQL" = {
        name                        = "Allow-MySQL"
        priority                    = 1010
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "3306"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
      },
      "Deny-All-Inbound" = {
        name                        = "Deny-All-Inbound"
        priority                    = 2000
        direction                   = "Inbound"
        access                      = "Deny"
        protocol                    = "*"
        source_port_range           = "*"
        destination_port_range      = "*"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
      }
    }
  }
]

network_interfaces = [
  {
    name         = "db-machine-nic"
    subnet_id    = null
    has_public_ip = false
  }
]

linux_vms = [
  {
    name                              = "mysql-server-machine"
    resource_group_name               = "your-resource-group-name"  
    location                          = "East US"                    
    size                              = "Standard_B1s"
    admin_username                    = "test_vm_so_far"
    admin_password                    = "testing_vms@123"
    disable_password_authentication    = false
    network_interface_names            = ["db-machine-nic"]              
    os_disk_caching                   = "ReadWrite"
    os_disk_storage_account_type      = "Standard_LRS"
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  custom_data_file = "/home/muhammad/Training/8_terraform/4_multiple_vms_to_host_wordpress/db_setup.sh"
  }
]

vmss_config = {
  name                = "my-scale-set"
  resource_group_name = "my-resource-group"
  location            = "East US"
  admin_username      = "adminuser"
  instance_count      = 2
  sku = "Standard_B1s"
  admin_ssh_key       = null
  subnet_id           = null
  nic_name = "vmss-nic"

  source_image_reference = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

