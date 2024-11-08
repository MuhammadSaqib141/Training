

managed_identities = {
    "identity001" : {
        user_identity_name = "azure-test"
        role_assignments = [
            {
                resource_type      = "storage_account"     
                resource_names      = ["saqibstorageaccount01" , "saqibstorageaccount02"]     
                role_definition_list    = ["Storage Blob Data Reader","Storage Blob Data Owner"]
            } 
        ]
    }
}