variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
}

variable "resource_group_location" {
  description = "The name of the resource group"
  type = string
}


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


# variables.tf

# variables.tf

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
