variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure location where resources will be created."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}

variable "storage_account_tier" {
  description = "The performance tier of the storage account."
  type        = string
}

variable "storage_account_replication" {
  description = "The replication type of the storage account."
  type        = string
}
