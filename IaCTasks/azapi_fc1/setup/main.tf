
resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = var.resourceGroupName
}



output "rg_map" {
  value = { for rg in [azurerm_resource_group.rg] : rg.name => rg.id }
  description = "Map of resource group name to resource group ID."
}

resource "azurerm_storage_account" "storageAccounttest" {
  name                     = "msstorageaccount0101"
  resource_group_name      = var.resourceGroupName
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [ azurerm_resource_group.rg ]
}


module "function_app" {
  source                     = "../modules/fc1_linux_app"
  resourceGroupName          = azurerm_resource_group.rg.name
  resourceGroupId            = azurerm_resource_group.rg.id
  location                   = azurerm_resource_group.rg.location
  enableAppInSight = false
  functionAppName            = var.functionAppName
  maximumInstanceCount       = var.maximumInstanceCount
  instanceMemoryMB           = var.instanceMemoryMB
  functionAppRuntime         = var.functionAppRuntime
  functionAppRuntimeVersion  = var.functionAppRuntimeVersion
  role_assignments           = var.role_assignments

  depends_on = [ azurerm_storage_account.storageAccounttest ]
  
}
