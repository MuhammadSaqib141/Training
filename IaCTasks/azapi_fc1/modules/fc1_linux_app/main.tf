data "azurerm_resource_group" "existing_rg" {
  name                = var.resourceGroupName
}

resource "azapi_resource" "serverFarm" {
  type                     = "Microsoft.Web/serverfarms@2024-04-01"
  schema_validation_enabled = false
  location                 = var.location
  name                     = "${var.functionAppName}Plan"
  parent_id = data.azurerm_resource_group.existing_rg.id

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
  name                     = "${var.functionAppName}storage"  
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
  name                = "${var.functionAppName}analytics"  
  location            = var.location
  resource_group_name = var.resourceGroupName
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "appInsights" {
  count = var.enableAppInSight ? 1 : 0
  name                = "${var.functionAppName}insight" 
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
  parent_id = data.azurerm_resource_group.existing_rg.id
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
  depends_on = [azapi_resource.serverFarm, azurerm_application_insights.appInsights, azurerm_storage_account.storageAccount]
}

data "azurerm_storage_account" "existing_storage" {
  for_each            = { for res in var.role_assignments : res.name => res if res.type == "storage" }
  name                = each.value.name
  resource_group_name = var.resourceGroupName
}

data "azurerm_servicebus_namespace" "existing_servicebus" {
  for_each            = { for res in var.role_assignments : res.name => res if res.type == "servicebus" }
  name                = each.value.name
  resource_group_name = var.resourceGroupName
}

locals {
  resource_ids = {
    for res in var.role_assignments : res.name => (
      res.type == "storage" ? data.azurerm_storage_account.existing_storage[res.name].id :
      res.type == "servicebus" ? data.azurerm_servicebus_namespace.existing_servicebus[res.name].id :
      null
    )
  }
}

resource "azurerm_role_assignment" "storage_roleassignment" {
  for_each = { for res in var.role_assignments : res.name => res }   
  scope                = local.resource_ids[each.value.name]
  role_definition_name = each.value.role_definition
  principal_id         = azapi_resource.functionApps.output.identity.principalId

  depends_on = [azapi_resource.functionApps]
}
