
resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = var.resourceGroupName
}



output "rg_map" {
  value = { for rg in [azurerm_resource_group.rg] : rg.name => rg.id }
  description = "Map of resource group name to resource group ID."
}



module "function_app" {
  source                     = "./fc1_linux_app"
  resourceGroupName          = azurerm_resource_group.rg.name
  resourceGroupId            = azurerm_resource_group.rg.id
  location                   = azurerm_resource_group.rg.location
  applicationInsightsName    = var.applicationInsightsName
  logAnalyticsName           = var.logAnalyticsName
  functionAppName            = var.functionAppName
  functionPlanName           = var.functionPlanName
  storageAccountName         = var.storageAccountName
  maximumInstanceCount       = var.maximumInstanceCount
  instanceMemoryMB           = var.instanceMemoryMB
  functionAppRuntime         = var.functionAppRuntime
  functionAppRuntimeVersion  = var.functionAppRuntimeVersion
}
