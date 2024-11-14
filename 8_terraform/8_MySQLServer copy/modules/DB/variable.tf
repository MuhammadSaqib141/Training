variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "The name of the resource location"
  type        = string
}

// mysql_server/variables.tf

// mysql_server/variables.tf

variable "mysql_config" {
  description = "MySQL configuration settings."
  type = object({
    resource_group_name     = string
    location                = string
    server_name             = string
    administrator_login     = string
    administrator_password   = string
    sku_name                = string
    database_name           = string
    charset                 = string
    collation               = string
  })
}

