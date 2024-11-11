variable "role_definition" {
  description = "The custom role definition object"
  type = object({
    name        = string
    scope       = string
    description = string
    permissions = object({
      actions          = list(string)
      not_actions      = list(string)
      data_actions     = list(string)
      not_data_actions = list(string)
    })
    assignable_scopes = list(string)
  })
}

variable "user_assigned_identity" {
  description = "The user-assigned identity object"
  type = object({
    name                = string
  })
}

variable "resource_group_name" {
  description = "The name of the resource group for the identity"
  type        = string
}
variable "location" {
  description = "The name of the location group for the identity"
  type        = string
}


# variable "role_assignment" {
#   description = "The role assignment object"
#   type = object({
#     scope                = string
#   })
# }
