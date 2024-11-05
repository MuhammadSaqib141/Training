variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure location where resources will be created."
  type        = string
}

variable "function_app_name" {
  description = "The name of the Linux function app."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}

variable "storage_account_access_key" {
  description = "The access key of the storage account."
  type        = string
}

variable "service_plan_id" {
  description = "The ID of the service plan."
  type        = string
}
