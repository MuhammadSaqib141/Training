locals {

     association_nsg_subnets = [
        {
        subnet_id = module.networking.wordpress_subnet_id.id
        nsg_id = module.networking.wordpress_nsg_id.id
        },
        {
        subnet_id = module.networking.db_subnet_id.id
        nsg_id = module.networking.db_nsg_id.id
        }
  ]

    network_interfaces = [
        {
            name         = "wordpress-machine-nic"
            subnet_id    = module.networking.wordpress_subnet_id.id
            has_public_ip = true
        } , 

        {
            name         = "db-machine-nic"
            subnet_id    = module.networking.db_subnet_id.id
            has_public_ip = false
        }
    ]

    association_nic_nsg = [
        {
        network_interface_name =  "wordpress-machine-nic"
        network_security_group_id = module.networking.wordpress_nsg_id.id
        } ,
        {
        network_interface_name =  "db-machine-nic"
        network_security_group_id = module.networking.db_nsg_id.id
        } 
    ]
}