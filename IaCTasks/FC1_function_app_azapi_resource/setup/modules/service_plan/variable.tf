variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure location where resources will be created."
  type        = string
}

variable "service_plan_name" {
  description = "The name of the service plan."
  type        = string
}

variable "os_type" {
  description = "The OS type for the service plan."
  type        = string
}

variable "sku_tier" {
  description = "The SKU tier for the service plan."
  type        = string
}

variable "sku_size" {
  description = "The SKU size for the service plan."
  type        = string
}
