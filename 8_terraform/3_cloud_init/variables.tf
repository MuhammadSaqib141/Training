variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The location/region where the resource group is created"
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network"
}

variable "address_space" {
  type        = list(string)
  description = "The address space for the virtual network"
}

variable "saqib_vnet_subnetA" {
  type        = string
  description = "Name of the first subnet"
}

variable "saqib_vnet_subnetB" {
  type        = string
  description = "Name of the second subnet"
}

variable "nsg_name" {
  type        = string
  description = "The name of the network security group"
}

variable "nsg_rule_name" {
  type        = string
  description = "The name of the network security rule"
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM"
}

variable "admin_password" {
  type        = string
  description = "Admin password for the VM"
}

# variable "ssh_public_key_path" {
#   type        = string
#   description = "Path to the SSH public key"
# }
