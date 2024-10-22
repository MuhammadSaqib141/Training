variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "The name of the resource location"
  type        = string
}

variable "virtual_networks" {
  description = "The name of networks in resource group"
  type        = list(object({
      name          = string
      address_space = list(string)
      location      = string
  }))
}

variable "subnets" {
  description = "The name of the resource group"
  type        = list(object({
      name          = string
      address_prefixes = list(string)
      virtual_network_name      = string
      nsg_to_be_associated = string
  }))
}

#------------- NSG & Rules Variables ------------------------
variable "nsgs" {
  description = "List of Network Security Groups configurations"
  type = list(object({
    name  = string
    rules = map(object({
      name                        = string
      priority                    = number
      direction                   = string
      access                      = string
      protocol                    = string
      source_port_range           = string
      destination_port_range      = string
      source_address_prefix       = string
      destination_address_prefix  = string
    }))
  }))
}

# variable "association_nsg_subnets" {
#   description = "value"
#   type = list(object({
#     subnet_id = string
#     nsg_id = string
#   }))
# }

variable "network_interfaces" {
  description = "List of network interfaces to be created"
  type = list(object({
    name         = string
    subnet_id    = string
    has_public_ip = bool
  }))
}

# variable "association_nic_nsg" {
#   description = "List of mappings between network interfaces and Network Security Groups"
#   type = list(object({
#     network_interface_name = string
#     network_security_group_id = string
#   }))
# }

variable "linux_vms" {
  description = "List of configurations for the Linux virtual machines."
  type = list(object({
    name                              = string
    resource_group_name               = string
    location                          = string
    size                              = string
    admin_username                    = string
    admin_password                    = string
    disable_password_authentication    = bool
    network_interface_names            = list(string)
    os_disk_caching                   = string
    os_disk_storage_account_type      = string
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    custom_data_file                  = string
  }))
}