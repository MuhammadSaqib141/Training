

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.resource_group_location
}



module "app_configuration" {
  source                  = "../modules/app_config"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  app_configuration = var.app_configuration

  depends_on = [azurerm_resource_group.example]
}





