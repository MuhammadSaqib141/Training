
resource "azurerm_resource_group" "example" {
  name     = "saqib-rg"
  location = "North Europe"
}


module "storage_account" {
  source                        = "../modules/storage_account"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  storage_account_name         = var.storage_account_name
  storage_account_tier         = var.storage_account_tier
  storage_account_replication   = var.storage_account_replication_type
}

module "service_plan" {
  source                = "../modules/service_plan"
  resource_group_name   = azurerm_resource_group.example.name
  location             = azurerm_resource_group.example.location
  service_plan_name     = var.service_plan_name
  os_type              = var.os_type
  sku_tier            = var.sku_tier
  sku_size            = var.sku_size
}

# module "linux_function_app" {
#   source                        = "../modules/linux_function_app"

#   for_each = toset(var.function_app_names)

#   function_app_name            = each.key
#   resource_group_name          = azurerm_resource_group.example.name
#   location                     = azurerm_resource_group.example.location
#   storage_account_name         = module.storage_account.storage_account_name
#   storage_account_access_key   = module.storage_account.storage_account_primary_access_key
#   service_plan_id              = module.service_plan.service_plan_id
# }


# module "app_service_connection" {
#   for_each = { for app in module.linux_function_app : app.linux_function_app_name => app }

#   source                   = "../modules/app_service_connection"
#   app_service_name         = "testappservicelink-${each.key}"  
#   function_app_name        = each.key                            
#   target_resource_name      = module.storage_account.storage_account_name  
#   resource_group_name       = azurerm_resource_group.example.name
#   auth_type  = "systemAssignedIdentity"  

# }

# module "app_service_connection" {

#   for_each = module.linux_function_app.linux_function_app_names

#   source                   = "../modules/app_service_connection"
#   app_service_name         = "testappservicelink-${each.key}"
#   app_service_id           = module.linux_function_app.linux_function_app_ids[each.key]
#   target_resource_id       = module.storage_account.storage_account_id  
#   resource_group_name      = azurerm_resource_group.example.name
#   auth_type                = "systemAssignedIdentity" 
# }


# output "linux_function_app_ids" {
#   value = [for app in module.linux_function_app : app.linux_function_app_id]
# }