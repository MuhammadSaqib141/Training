output "role_definition_id" {
  description = "The ID of the created custom role definition"
  value       = azurerm_role_definition.custom_role.id
}

output "user_assigned_identity_id" {
  description = "The ID of the created user-assigned identity"
  value       = azurerm_user_assigned_identity.example.id
}

output "role_assignment_id" {
  description = "The ID of the created role assignment"
  value       = azurerm_role_assignment.example.id
}
