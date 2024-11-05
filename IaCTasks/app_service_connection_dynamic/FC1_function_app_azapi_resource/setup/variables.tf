

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default = "saqib-rg"
}

variable "location" {
  description = "The Azure location where resources will be created."
  type        = string
  default = "North Europe"
}

variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}

variable "storage_account_tier" {
  description = "The performance tier of the storage account."
  type        = string
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "The replication type of the storage account."
  type        = string
  default     = "LRS"
}

variable "service_plan_name" {
  description = "The name of the service plan."
  type        = string
}

variable "os_type" {
  description = "The OS type for the service plan."
  type        = string
  default     = "Linux"
}

variable "sku_tier" {
  description = "The SKU tier for the service plan."
  type        = string
  default     = "Basic"
}

variable "sku_size" {
  description = "The SKU size for the service plan."
  type        = string
  default     = "B1"
}

# variable "function_app_name" {
#   description = "The name of the Linux function app."
#   type        = string
# }

variable "function_app_names" {
  description = "List of function app names"
  type        = list(string)
}


# variable "app_service_name" {
#   description = "The name of the Azure App Service"
#   type        = string
# }

# variable "app_service_id" {
#   description = "The ID of the Azure App Service"
#   type        = string
# }

# variable "target_resource_id" {
#   description = "The ID of the target Azure resource (e.g., Cosmos DB)"
#   type        = string
# }