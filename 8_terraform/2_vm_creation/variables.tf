variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy the resources in"
  type        = string
}

variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
}

variable "address_space" {
  description = "The address space for the Virtual Network"
  type        = list(string)
}

variable "saqib_vnet_subnetA" {
  description = "The name of the first subnet"
  type        = string
}

variable "saqib_vnet_subnetB" {
  description = "The name of the second subnet"
  type        = string
}

variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
}

variable "nsg_rule_name" {
  description = "The name of the Network Security Rule"
  type        = string
}

variable "admin_username" {
  description = "The admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the VM (if not using SSH key)"
  type        = string
  sensitive   = true
}

variable "ssh_public_key_path" {
  description = "The path to the SSH public key"
  type        = string
}
