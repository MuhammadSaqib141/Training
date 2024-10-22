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

variable "network_interfaces" {
  description = "List of network interfaces to be created"
  type = list(object({
    name         = string
    subnet_id    = string
    has_public_ip = bool
  }))
}

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

variable "vmss_config" {
  description = "Configuration for the virtual machine scale set"
  type = object({
    name                = string
    resource_group_name = string
    location            = string
    admin_username      = string
    instance_count      = number
    sku                 = string
    admin_ssh_key       = string
    subnet_id           = string
    nic_name            = string

    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })

    os_disk = object({
      caching              = string
      storage_account_type = string
    })
  })
}
