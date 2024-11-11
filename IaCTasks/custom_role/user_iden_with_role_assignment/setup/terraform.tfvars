role_definition = {
  name        = "CustomRoleForManagedIdentity"
  description = "Custom role for managed identity granting access to Service Bus and Storage Accounts."
  scope = "value"
  permissions = {
    actions          = [
      "Microsoft.ServiceBus/namespaces/*",
      "Microsoft.ServiceBus/namespaces/topics/*",
      "Microsoft.Storage/storageAccounts/*",
      "Microsoft.Storage/storageAccounts/blobServices/*"
    ]
    not_actions      = []
    data_actions     = []
    not_data_actions = []
  }
    assignable_scopes = ["/subscriptioroups/saqib-rg"]
}

user_assigned_identity = {
  name                = "example-managed-identity"
  location            = "East US"
  resource_group_name = "saqib-rg"
}

