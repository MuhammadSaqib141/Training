variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "The name of the resource location"
  type        = string
}

variable "virtual_networks" {
  description = "Map of virtual networks and their subnets"
  type = map(object({
    name          = string
    address_space = list(string)
    location      = string
    subnet_configs = map(object({
      name                 = string
      address_prefixes     = list(string)
      nsg_to_be_associated = string
      virtual_network_key  = string
    }))
  }))
}

variable "nsgs" {
  description = "Map of Network Security Groups with rules"
  type = map(object({
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

variable "public_ips" {
  description = "Map of public IP addresses"
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method   = string
    sku                 = string
    zones               = list(string)
  }))
}

variable "nat_gateways" {
  description = "Map of NAT Gateways and their configurations"
  type = map(object({
    name                    = string
    location                = string
    resource_group_name     = string
    sku_name                = string
    idle_timeout_in_minutes = number
    zones                   = list(string)
    public_ips              = list(string)  # List of public IP names to associate
        subnet_to_be_attached    = string

  }))
}

variable "network_interfaces" {
  description = "Map of network interfaces to be created"
  type = map(object({
    name          = string
    subnet_id     = string
    has_public_ip = bool
    # public_ip_is  = string
  }))
}

variable "linux_vms" {
  description = "Map of configurations for the Linux virtual machines."
  type = map(object({
    name                              = string
    resource_group_name               = string
    location                          = string
    size                              = string
    admin_username                    = string
    admin_password                    = string
    disable_password_authentication   = bool
    network_interface_names           = list(string)
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