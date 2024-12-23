# variables.tf


variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "saqib-rg"
}

variable "location" {
  description = "Location for all resources"
  type        = string
  default     = "North Europe"
}

variable "vnet_name" {
  description = "Virtual network name"
  type        = string
  default     = "saqib-vnet"
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
