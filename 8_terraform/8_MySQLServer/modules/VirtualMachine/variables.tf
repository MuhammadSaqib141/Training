variable "resource_group_name" {
  description = "Resource group name for the VM"
  type        = string
}

variable "resource_group_location" {
  description = "Location for the resource group"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the network interface"
  type        = string
}

variable "public_ip" {
  description = "Subnet ID for the network interface"
  type        = string
}

variable "network_interface" {
  description = "Network interface configuration"
  type        = object({
    name         = string
    has_public_ip = bool
  })
}

variable "linux_vm" {
  description = "Linux VM configuration"
  type        = object({
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
}