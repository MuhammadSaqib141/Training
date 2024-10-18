resource_group_name = "saqib-rg"

resource_group_location = "North Europe" 

virtual_networks = [
  {
    name          = "saqib-vnet"
    address_space = ["10.0.0.0/16"]
    location      = "North Europe"
  }
]

subnet_blocks = [
  {
    name                 = "subnet1"
    virtual_network_name = "saqib-vnet"
    address_prefixes     = ["10.0.1.0/24"]
  },
  {
    name                 = "subnet2"
    virtual_network_name = "saqib-vnet"
    address_prefixes     = ["10.0.2.0/24"]
  }
]

nsg_name = "wordpress_nsg"

security_rules = {


  "Allow-SSH" = {
    name                        = "Allow-SSH"
    priority                    = 1000
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix   = "*"
  },
  
  "Allow-HTTP" = {
    name                        = "Allow-HTTP"
    priority                    = 1010
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "*"
    destination_address_prefix   = "*"
  },
  
  "Deny-All-Inbound" = {
    name                        = "Deny-All-Inbound"
    priority                    = 2000
    direction                   = "Inbound"
    access                      = "Deny"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "*"
    destination_address_prefix   = "*"
  }
}

nic_name = "nic_card"

