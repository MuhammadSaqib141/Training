variable "resource_group_name" {
    type = string  
}

variable "resource_group_location" {
    type = string  
}

variable "user_identity_name" {
    type = string  
}

variable "role_assignments" {
  description = "List of resources for which role assignments are needed"
    type = list(object({
        resource_type      = string     
        resource_names      = list(string)     
        role_definition_list    = list(string)
    }))
}

