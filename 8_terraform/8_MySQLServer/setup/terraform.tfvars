
resource_group_name = "saqib-rg"
resource_group_location = "North Europe" 

networking_config = {
  "vnet1" = {
    virtual_network = {
      name          = "saqib-vnet"
      address_space = ["10.0.0.0/16"]
      location      = "East US"
    }
    subnets = {
      "subnet1" = {
        name             = "subnet1"
        address_prefixes = ["10.0.1.0/24"]
        nsg_association  = "wordpress-nsg"  # Reference to NSG
      }
      "subnet2" = {
        name             = "subnet2"
        address_prefixes = ["10.0.2.0/24"]
        nsg_association  = null  # No NSG association
      }
    }
    public_ips = {
        publicIp1 = {
            name              = "wordpress-ip"
            allocation_method = "Static"
        }
    }
    nsg = {
      name  = "wordpress-nsg"
      rules = {
        "allow_http" = {
          name                        = "AllowHTTP"
          priority                    = 1000
          direction                   = "Inbound"
          access                      = "Allow"
          protocol                    = "Tcp"
          source_port_range           = "*"
          destination_port_range      = "80"
          source_address_prefix       = "*"
          destination_address_prefix  = "*"
        }
      }
    }
  }
}
mysql_config = {
  resource_group_name     = null          # Replace with your resource group name
  location                = null  # Replace with your preferred location
  server_name             = "wordpress-testing-server"       # The name of your MySQL server
  administrator_login     = "wordpress_user"                 # MySQL admin username
  administrator_password   = "M@lik8872"                      # MySQL admin password
  sku_name                = "B_Standard_B1s"                 # SKU for the server
  database_name           = "wordpress_db"                   # Name of the database to create
  charset                 = "utf8"                            # Charset for the database
  collation               = "utf8_unicode_ci"                # Collation for the database
}

vm_configs = {
    "wordpress" = {
      vm = {
        name                          = "wordpress"
        size                          = "Standard_B1s"
        admin_username                = "azureuser"
        admin_password                = "vm_password" //actually it is secret name
        disable_password_authentication = false
        os_disk_caching               = "ReadWrite"
        os_disk_storage_account_type  = "Standard_LRS"  
        source_image_reference        = {
          publisher = "Canonical"
          offer     = "UbuntuServer"
          sku       = "18.04-LTS"
          version   = "latest"
        }
        custom_data_file              = "/wordpress.tpl"
      }
      nic = {
        name         = "wordpress-nic"
        has_public_ip = true
        public_ip_is  = null
      }
      subnet_id = "subnet1" 
      public_ip = "publicIp1"
      network_name = "vnet1"
    }
}


key_vault_config  = {
    name                        = "examplekeyvault-vm"  
    location                    = null
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"
    access_policy = [
      {
        tenant_id        = null
        object_id        = null
        key_permissions   = ["Get"]
        secret_permissions = ["Get","Set","Delete","List","Purge"]
        storage_permissions = ["Get"]
      }
    ]
}

secrets = {
  vm_password = {
    name  = "vm-password"
    value = "M@lik8872"
  }
}
