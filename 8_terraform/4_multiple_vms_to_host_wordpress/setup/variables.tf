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

variable "subnet_blocks" {
  description = "The name of the resource group"
  type        = list(object({
      name          = string
      address_prefixes = list(string)
      virtual_network_name      = string
  }))
}

#------------- NSG & Rules Variables ------------------------

variable "nsg_name" {
  description = "The name of the nsg"
  type        = string
}

variable "security_rules" {
  description = "List of network security rules for the NSG"
  type = map(object({
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
}

#---------------------------------------------------------------
variable "nic_name" {
  description = "The name of the nuc "
  type = string
}