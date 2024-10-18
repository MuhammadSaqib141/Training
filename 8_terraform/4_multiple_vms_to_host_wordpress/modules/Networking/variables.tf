variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
}

variable "resource_group_location" {
  description = "The name of the resource group"
  type = string
}


variable "virtual_networks" {
  description = "The name of the resource group"
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
  }))
}


#------------- NSG & Rules Variables ------------------------

variable "nsgs" {
  description = "A map of NSG configurations"
  type        = map(object({
    name       = string
    rules      = list(object({
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

