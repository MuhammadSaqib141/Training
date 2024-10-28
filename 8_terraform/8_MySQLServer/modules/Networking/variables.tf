variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
}

variable "resource_group_location" {
  description = "The name of the resource group"
  type = string
}

# Variable for the virtual network configuration
variable "virtual_network" {
  description = "Virtual network configuration"
  type = object({
    name          = string
    address_space = list(string)
    location      = string
  })
}

variable "subnets" {
  description = "List of subnets to create within the virtual network"
  type = map(object({
    name             = string
    address_prefixes = list(string)
    nsg_association  = string
  }))
}

variable "public_ips" {
  description = "List of public IPs to create"
  type = map(object({
    name              = string
    allocation_method = string
  }))
}

variable "nsg" {
  description = "List of network security groups to create"
  type = object({
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
  })
}