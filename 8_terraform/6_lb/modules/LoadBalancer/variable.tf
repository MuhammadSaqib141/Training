variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
}

variable "resource_group_location" {
  description = "The name of the resource group"
  type = string
}


variable "lb_config" {
  description = "Load Balancer configuration settings."
  type = object({
    lb_name                     = string
    location                    = string
    resource_group_name         = string
    frontend_ip_name            = string
    public_ip_address_id        = string
    backend_pool_name           = string
    nat_pool_name               = string
    nat_pool_protocol           = string
    nat_pool_frontend_port_start = number
    nat_pool_frontend_port_end   = number
    nat_pool_backend_port       = number
    probe_name                  = string
    probe_protocol              = string
    probe_request_path          = string
    probe_port                  = number
  })
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
