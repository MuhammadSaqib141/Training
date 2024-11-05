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




variable "functionAppName" {
  description = "The Function App name."
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

variable "role_assignments" {
  description = "List of resources for which role assignments are needed"
  type = list(object({
    type               = string     
    name                = string     
    role_definition    = string     
  }))
}