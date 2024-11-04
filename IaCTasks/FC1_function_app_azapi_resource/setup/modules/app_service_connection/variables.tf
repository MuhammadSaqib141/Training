variable "app_service_name" {
  description = "The name of the app service connection."
  type        = string
}

# variable "function_app_name" {
#   description = "The name of the Linux Function App to connect to."
#   type        = string
# }

# variable "target_resource_name" {
#   description = "The name of the target resource (Storage Account) to connect to."
#   type        = string
# }

variable "resource_group_name" {
  description = "The resource group name where the function app and target resource exist."
  type        = string
}


variable "auth_type" {
  description = "The resource group name where the function app and target resource exist."
  type        = string
}