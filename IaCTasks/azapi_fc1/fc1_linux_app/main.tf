resource "azapi_resource" "serverFarm" {
  type                     = "Microsoft.Web/serverfarms@2024-04-01"
  schema_validation_enabled = false
  location                 = var.location
  name                     = var.functionPlanName
  parent_id = var.resourceGroupId

  body = {
    kind = "functionapp",
    sku  = {
      tier = "FlexConsumption",
      name = "FC1"
    },
    properties = {
      reserved = true
    }
  }
}

resource "azurerm_storage_account" "storageAccount" {
  name                     = var.storageAccountName
  resource_group_name      = var.resourceGroupName
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "storageContainer" {
  name                  = "deploymentpackage"
  storage_account_name  = azurerm_storage_account.storageAccount.name
  container_access_type = "private"
}

resource "azurerm_log_analytics_workspace" "logAnalyticsWorkspace" {
  count = var.enableAppInSight ? 1 : 0
  name                = var.logAnalyticsName
  location            = var.location
  resource_group_name = var.resourceGroupName
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "appInsights" {
  count = var.enableAppInSight ? 1 :0
  name                = var.applicationInsightsName
  location            = var.location
  resource_group_name = var.resourceGroupName
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.logAnalyticsWorkspace[0].id 
}

locals {
  blobStorageAndContainer = "${azurerm_storage_account.storageAccount.primary_blob_endpoint}deploymentpackage"
}

resource "azapi_resource" "functionApps" {
  type = "Microsoft.Web/sites@2023-12-01"
  schema_validation_enabled = false
  location = var.location
  name = var.functionAppName
  parent_id = var.resourceGroupId
  body = {
    kind = "functionapp,linux",
    identity = {
      type = "SystemAssigned"
    }
    properties = {
      serverFarmId = azapi_resource.serverFarm.id,
        functionAppConfig = {
          deployment = {
            storage = {
              type = "blobContainer",
              value = local.blobStorageAndContainer,
              authentication = {
                type = "SystemAssignedIdentity"
              }
            }
          },
          scaleAndConcurrency = {
            maximumInstanceCount = var.maximumInstanceCount,
            instanceMemoryMB = var.instanceMemoryMB
          },
          runtime = { 
            name = var.functionAppRuntime, 
            version = var.functionAppRuntimeVersion
          }
        },
        siteConfig = {
          appSettings = [
            {
              name = "AzureWebJobsStorage__accountName",
              value = azurerm_storage_account.storageAccount.name
            },
            {
              name = "APPLICATIONINSIGHTS_CONNECTION_STRING",
            value = var.enableAppInSight ? azurerm_application_insights.appInsights[0].connection_string : null
            }
          ]
        }
      }
  }
  depends_on = [ azapi_resource.serverFarm, azurerm_application_insights.appInsights, azurerm_storage_account.storageAccount ]
}

# resource "azurerm_role_assignment" "storage_roleassignment" {
#   scope                = azurerm_storage_account.storageAccount.id
#   role_definition_name = "Storage Blob Data Contributor"  
#   principal_id         = azapi_resource.functionApps.output.identity.principalId

#   depends_on = [azapi_resource.functionApps]
# }


resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resourceGroupName
}

resource "azurerm_subnet" "example" { 
  name = "example-subnet" 
  resource_group_name = azurerm_virtual_network.example.resource_group_name 
  virtual_network_name = azurerm_virtual_network.example.name 
  address_prefixes = ["10.0.1.0/24"] 
  service_endpoints = ["Microsoft.Storage", "Microsoft.Sql", "Microsoft.ServiceBus"] 
  delegation { 
    name = "Microsoft.DBforMySQL/flexibleServers" 

    service_delegation { 
    name = "Microsoft.DBforMySQL/flexibleServers"
     actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
      }
    } 
  
}



resource "azurerm_app_service_virtual_network_swift_connection" "example" {
  app_service_id = azapi_resource.functionApps.id
  subnet_id      = azurerm_subnet.example.id
}

resource "azurerm_mysql_flexible_server" "example" {
  name                = "example-mysql-server"
  resource_group_name = var.resourceGroupName
  location            = var.location
  administrator_login = "mysqladmin"
  administrator_password = "H@Sh1CoR3!"
  sku_name               = "GP_Standard_D2ds_v4"
  depends_on          = [azurerm_virtual_network.example, azurerm_subnet.example]
}

resource "azurerm_role_assignment" "mysql_role_assignment" { 
  scope = azurerm_mysql_flexible_server.example.id 
  role_definition_name = "Contributor"
   principal_id = azapi_resource.functionApps.output.identity.principalId 
   depends_on = [azapi_resource.functionApps, azurerm_mysql_flexible_server.example] 
}