
resource_group_name    = "test-resource-group"
resource_group_location = "North Europe"


app_configuration = {
  name                       = "my-app-configuration"
  sku                        = "free"
  # local_auth_enabled         = true
  # public_network_access      = "Enabled"
  # purge_protection_enabled   = false
  # soft_delete_retention_days = 7
  # system_assigned_identity_enabled = false
  # identity_ids               = []
  # tags = {
  #   environment = "dev"
  #   owner       = "team-a"
  # }

  # replica = [
  #   {
  #     name     = "replica1"
  #     location = "westus"
  #   },
  #   {
  #     name     = "replica2"
  #     location = "eastus2"
  #   }
  # ]

  # encryption = null
}
    