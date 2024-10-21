resource_group_name = "saqib-rg"

resource_group_location = "North Europe" 

virtual_networks = [
  {
    name          = "saqib-vnet"
    address_space = ["10.0.0.0/16"]
    location      = "North Europe"
  }
]

subnet_blocks = [
  {
    name                 = "subnet1"
    virtual_network_name = "saqib-vnet"
    address_prefixes     = ["10.0.1.0/24"]
  },
  {
    name                 = "subnet2"
    virtual_network_name = "saqib-vnet"
    address_prefixes     = ["10.0.2.0/24"]
  }
]

nsgs = [
  {
    name  = "wordpress-nsg-1"
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
      "Allow-HTTP" = {
        name                        = "Allow-HTTP"
        priority                    = 1010
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "80"
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
  },
  {
    name  = "wordpress-nsg-2"
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


association_nsg_subnets = [
  {
    subnet_id = null
    nsg_id = null
  }
]


network_interfaces = [
  {
    name         = "wordpress-machine-nic"
    subnet_id    = null
    has_public_ip = true
  } ,

  {
    name         = "db-machine-nic"
    subnet_id    = null
    has_public_ip = false
  }
]

association_nic_nsg = [
  {
    network_interface_name = null
    network_security_group_id = null
  }
]


linux_vms = [
  {
    name                              = "wordpess-machine"
    resource_group_name               = "your-resource-group-name"  
    location                          = "East US"                    
    size                              = "Standard_B1s"
    admin_username                    = "test_vm_so_far"
    admin_password                    = "testing_vms@123"
    disable_password_authentication    = false
    network_interface_names            = ["wordpress-machine-nic"]
    os_disk_caching                   = "ReadWrite"
    os_disk_storage_account_type      = "Standard_LRS"
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
    custom_data_file                  = "/home/muhammad/Training/8_terraform/3_cloud_init/wordpress.yml"
  },
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