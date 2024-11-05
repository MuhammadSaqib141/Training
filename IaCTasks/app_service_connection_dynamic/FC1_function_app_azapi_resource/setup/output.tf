output "functionAppId" {
  description = "The ID of the Function App."
  value       = azapi_resource.functionApps.id
}

output "appInsightsConnectionString" {
  description = "Connection string for Application Insights."
  value       = azurerm_application_insights.appInsights.connection_string
}
