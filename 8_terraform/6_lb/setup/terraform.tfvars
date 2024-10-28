
resource_group_name = "saqib-rg"
resource_group_location = "North Europe" 

virtual_networks = {
  "saqib-vnet" = {
    name          = "saqib-vnet"
    address_space = ["10.0.0.0/16"]
    location      = "North Europe"
    subnet_configs = {
      "subnet1" = {
        name                  = "subnet1"
        address_prefixes      = ["10.0.1.0/24"]
        nsg_to_be_associated  = "wordpress-nsg"
        virtual_network_key   = "saqib-vnet"
      },
      "subnet2" = {
        name                  = "subnet2"
        address_prefixes      = ["10.0.2.0/24"]
        nsg_to_be_associated  = "mysql-nsg"
        virtual_network_key   = "saqib-vnet"
      }
    }
  } ,

}

nsgs = {
  "wordpress-nsg" = {
    name  = "wordpress-nsg"
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
  "mysql-nsg" = {
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
}

public_ips = {
    "nat-ip" = {
      name                = "nat-ip"
      location            =  null
      resource_group_name =  null
      allocation_method   = "Static"
      sku                 = "Standard"
      zones               = ["1"]
    }
    "PublicIPAddressForLB" = {
      name                = "PublicIPAddressForLB"
      location            =  null
      resource_group_name =  null
      allocation_method   = "Static"
      sku                 = "Standard"
      zones               = ["1"]
    } 
}

nat_gateways = {
  "my_nat_gateway" = {
    name                    = "my-nat-gateway"
    location                = "North Europe"
    resource_group_name     = "my-resource-group"
    sku_name                = "Standard"
    idle_timeout_in_minutes = 10
    zones                   = ["1"]
    public_ips              = ["nat-ip"]
    subnet_to_be_attached    = "subnet1"

  }
}

network_interfaces = {
  "wordpress-nic" = {
    name         = "wordpress-nic"
    subnet_id    = null
    has_public_ip = false
    public_ip_is = "wordpress-ip"
  }
}


linux_vms = {
  "mysql-server-machine" = {
    name                              = "mysql-server-machine"
    resource_group_name               = "your-resource-group-name"
    location                          = "East US"
    size                              = "Standard_B1s"
    admin_username                    = "test_vm_so_far"
    admin_password                    = "testing_vms@123"
    disable_password_authentication   = false
    network_interface_names           = ["mysql-nic"]
    os_disk_caching                   = "ReadWrite"
    os_disk_storage_account_type      = "Standard_LRS"
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
    custom_data_file                  = "/home/muhammad/Training/8_terraform/4_multiple_vms_to_host_wordpress/db_setup.sh"
  }
}


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

lb_config = {
  lb_name                     = "test-lb"
  location                    = null
  resource_group_name         = null
  frontend_ip_name            = "PublicIPAddressForLB"
  public_ip_address_id        = "/subscriptions/.../resourceGroups/example-rg/providers/Microsoft.Network/publicIPAddresses/example-pubip"
  backend_pool_name           = "BackEndAddressPool"
  nat_pool_name               = "ssh"
  nat_pool_protocol           = "Tcp"
  nat_pool_frontend_port_start = 50000
  nat_pool_frontend_port_end   = 50119
  nat_pool_backend_port       = 22
  probe_name                  = "http-probe"
  probe_protocol              = "Http"
  probe_request_path          = "/health"
  probe_port                  = 8080
}