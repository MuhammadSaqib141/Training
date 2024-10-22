locals { 

    network_interfaces = [
        {
            name         = "db-machine-nic"
            subnet_id    = module.networking.db_subnet_id
            has_public_ip = false
        }
    ]


    vmss_config = {
        name                = "my-scale-set"
        resource_group_name = "my-resource-group"
        location            = "East US"
        admin_username      = "adminuser"
        instance_count      = 2
        sku = "Standard_B1s"
        admin_ssh_key       = null
        subnet_id           = module.networking.wordpress_subnet_id
        nic_name = "vmss-nic"

        source_image_reference = {
            publisher = "Canonical"
            offer     = "UbuntuServer"
            sku       = "18.04-LTS"
            version   = "latest"
        }

        os_disk = {
            caching              = "ReadWrite"
            storage_account_type = "Standard_LRS"
        }
    }

}