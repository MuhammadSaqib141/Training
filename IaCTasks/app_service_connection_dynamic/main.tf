
module "app_service_connection" { //set data according to need and array tested on functions app behaviour only

  for_each = module.linux_function_app.linux_function_app_names

  source                   = "../modules/app_service_connection"
  app_service_name         = "testappservicelink-${each.key}"
  app_service_id           = module.linux_function_app.linux_function_app_ids[each.key]
  target_resource_id       = module.storage_account.storage_account_id  
  resource_group_name      = azurerm_resource_group.example.name
  auth_type                = "systemAssignedIdentity" 
}


