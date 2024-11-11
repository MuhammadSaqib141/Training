
# variable "role_assignments" {
#     description = "List of resources for which role assignments are needed"
#     type = list(object({
#         resource_type      = string     
#         resource_name      = string     
#         role_definition_list    = list(string)
#     }))
#     default = [
#         {
#             resource_type      = "storage_account"     
#             resource_name      = "saqibstorageaccount01"     
#             role_definition_list    = ["Storage Blob Data Reader","Storage Blob Data Owner"]
#         } ,
#         {
#             resource_type      = "service_bus"     
#             resource_name      = "pub-sub-app"     
#             role_definition_list    = ["Azure Service Bus Data Owner"]
#         }

#     ]
# }


variable "managed_identities" {
  type = map(object({
    user_identity_name = string

    role_assignments = list(object({
        resource_type      = string     
        resource_names      = list(string)     
        role_definition_list    = list(string)
    }))
  }))
}

