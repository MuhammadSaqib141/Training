locals { 
    network_interfaces = [
        {
            name         = "wordpress-machine-nic"
            subnet_id    = module.networking.wordpress_subnet_id
            has_public_ip = true
        } , 
        {
            name         = "db-machine-nic"
            subnet_id    = module.networking.db_subnet_id
            has_public_ip = false
        }
    ]
}