variable "resourceGroupName" {
  description = "The Azure Resource Group name."
  type        = string
}

variable "resourceGroupId" {
  description = "The Azure Resource Group Id."
  type        = string
}


variable "location" {
  description = "The Azure Region."
  type        = string
}


variable "enableAppInSight" {
  description = "The Application Insights name."
  type        = bool
  default = false
}


variable "applicationInsightsName" {
  description = "The Application Insights name."
  type        = string
}

variable "logAnalyticsName" {
  description = "The Log Analytics name."
  type        = string
}

variable "functionAppName" {
  description = "The Function App name."
  type        = string
}

variable "functionPlanName" {
  description = "The App Service plan name for the function."
  type        = string
}

variable "storageAccountName" {
  description = "The Storage Account name."
  type        = string
}

variable "maximumInstanceCount" {
  description = "The maximum instance count for the app."
  type        = number
}

variable "instanceMemoryMB" {
  description = "The instance memory for the app."
  type        = number
}

variable "functionAppRuntime" {
  description = "The runtime for the function app (e.g., dotnet-isolated, python)."
  type        = string
}

variable "functionAppRuntimeVersion" {
  description = "The runtime version for the function app."
  type        = string
}
