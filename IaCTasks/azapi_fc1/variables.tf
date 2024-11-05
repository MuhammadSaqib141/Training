variable "resourceGroupName" {
  description = "The Azure Resource Group name in which all resources in this example should be created."
  default = "saqib-rg"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default = "North Europe"
}

variable "applicationInsightsName" {
  description = "Your Application Insights name."
  default = "testApplicationInsight"
}

variable "logAnalyticsName" {
  description = "Your Log Analytics name."
  default = "logAnalyticsTest"
}

variable "functionAppName" {
  description = "Your Flex Consumption app name."
  default = "msfunctionapptest001"
}

variable "functionPlanName" {
  default = "flex-consumption-plan"
}


variable "storageAccountName" {
  description = "Your storage account name."
  default = "msstorageacctest001"
}

variable "maximumInstanceCount" {
  default = 100
  description = "The maximum instance count for the app"
}

variable "instanceMemoryMB" {
  default = 2048
  description = "The instance memory for the instances of the app: 2048 or 4096"
}

variable "functionAppRuntime" {
  default = "java"
  description = "The runtime for your app. One of the following: 'dotnet-isolated', 'python', 'java', 'node', 'powershell'"
}

variable "functionAppRuntimeVersion" {
  default = "17"
  description = "The runtime and version for your app. One of the following: '3.10', '3.11', '7.4', '8.0', '10', '11', '17', '20'"
}
