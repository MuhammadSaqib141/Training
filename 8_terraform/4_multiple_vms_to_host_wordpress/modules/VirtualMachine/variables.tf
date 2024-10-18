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
