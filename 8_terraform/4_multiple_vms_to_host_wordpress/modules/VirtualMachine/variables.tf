variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
}

variable "resource_group_location" {
  description = "The name of the resource group"
  type = string
}


variable "nic_name" {
  description = "The name of the nuc "
  type = string
}

variable "subnet_ids" {
  description = "The map of subnet IDs"
  type        = map(string)
}


variable "network_interfaces" {
  description = "A list of network interface configurations"
  type = list(object({
    name            = string
    has_public_ip   = bool // Flag to indicate if the NIC should have a public IP
    subnet_id       = string // Subnet ID where the NIC will be attached
  }))
  default = [
    {
      name          = "linuxvm-nic-with-public-ip"
      has_public_ip = true
      subnet_id     = var.subnet_ids["0"] 
    },
    {
      name          = "linuxvm-nic-without-public-ip"
      has_public_ip = false
      subnet_id     = var.subnet_ids["1"] 
    }
  ]
}