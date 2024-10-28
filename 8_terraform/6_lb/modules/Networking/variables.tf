variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
}

variable "resource_group_location" {
  description = "The name of the resource group"
  type = string
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
    public_ips              = list(string)  
    subnet_to_be_attached    = string
  }))
}

#------------- NSG & Rules Variables ------------------------
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


# variable "association_nsg_subnets" {
#   description = "value"
#   type = list(object({
#     subnet_id = string
#     nsg_id = string
#   }))
# }