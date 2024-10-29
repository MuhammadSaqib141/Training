variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "The name of the resource location"
  type        = string
}

variable "networking_config" {
  default = {
    vnet1 = {
      virtual_network = {
        name          = "vnet1"
        address_space = ["10.0.0.0/16"]
        location      = "East US"
      }
      subnets = {
        subnet1 = {
          name             = "subnet1"
          address_prefixes = ["10.0.1.0/24"]
        }
        subnet2 = {
          name             = "subnet2"
          address_prefixes = ["10.0.2.0/24"]
          nsg_association  = "nsg1"
        }
      }
      public_ips = {  # Updated to use a map of public IPs
        publicIp1 = {
          name              = "publicIp1"
          allocation_method = "Dynamic"
        }
        publicIp2 = {
          name              = "publicIp2"
          allocation_method = "Static"
        }
      }
      nsg = {
        name  = "nsg1"
        rules = {
          rule1 = {
            name                        = "AllowHttp"
            priority                    = 100
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
}

variable "vm_configs" {
  description = "Map of VM and network interface configurations"
  type = map(object({
    vm = object({
      name                          = string
      size                          = string
      admin_username                = string
      admin_password                = string
      disable_password_authentication = bool
      os_disk_caching               = string
      os_disk_storage_account_type  = string
      source_image_reference        = object({
        publisher = string
        offer     = string
        sku       = string
        version   = string
      })
      custom_data_file              = string
    })
    nic = object({
      name         = string
      has_public_ip = bool
      public_ip_is  = optional(string)
    })
    subnet_id = string  
    public_ip = string   
    network_name = string
  }))
}

variable "mysql_config" {
  description = "Configuration for MySQL server and database."
  type = object({
    server_name             = string
    resource_group_name     = string
    location                = string
    administrator_login     = string
    administrator_password  = string
    sku_name                = string
    database_name           = string
    charset                 = string
    collation               = string
  })
}

variable "key_vault_config" {
  type = object({
    name                        = string
    location                    = string
    enabled_for_disk_encryption = bool
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool
    sku_name                    = string
    access_policy = list(object({
      tenant_id        = string
      object_id        = string
      key_permissions   = list(string)
      secret_permissions = list(string)
      storage_permissions = list(string)
    }))
  })


}

variable "secrets" {
  type = map(object({
    name  = string
    value = string
  }))
}