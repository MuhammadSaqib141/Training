
resource "azurerm_mysql_flexible_server" "this" {
  name                   = var.mysql_config.server_name
  resource_group_name    = var.resource_group_name                # Correct usage of resource group name
  location               = var.resource_group_location             # Correctly using resource group location
  administrator_login    = var.mysql_config.administrator_login
  administrator_password  = var.mysql_config.administrator_password
  sku_name               = var.mysql_config.sku_name
}

resource "azurerm_mysql_flexible_database" "this" {
  name                = var.mysql_config.database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.this.name
  charset             = var.mysql_config.charset
  collation           = var.mysql_config.collation
}

