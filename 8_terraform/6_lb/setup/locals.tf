
locals { 

    network_interfaces = {
    "mysql-nic" = {
      name          = "wordpress-nic"
      subnet_id     = module.networking.subnets["subnet1"].id
      has_public_ip = true
    }
  }

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

    lb_config = {
        lb_name                     = "test-lb"
        location                    = "north europe"
        resource_group_name         = "saqib-rg"
        frontend_ip_name            = "PublicIPAddressForLB"
        public_ip_address_id        = module.networking.PublicIPAddressForLB
        backend_pool_name           = "BackEndAddressPool"
        nat_pool_name               = "ssh"
        nat_pool_protocol           = "Tcp"
        nat_pool_frontend_port_start = 50000
        nat_pool_frontend_port_end   = 50119
        nat_pool_backend_port       = 22
        probe_name                  = "http-probe"
        probe_protocol              = "Http"
        probe_request_path          = "/health"
        probe_port                  = 8080
    }
}