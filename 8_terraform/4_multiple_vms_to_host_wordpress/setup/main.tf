// Create the resource group first
resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.resource_group_location
}


// locals.tf
locals {
  nsg_configs = {
    "web_nsg" = {
      name  = "web-nsg"
      rules = [
        {
          name                        = "AllowHTTP"
          priority                    = 100
          direction                   = "Inbound"
          access                      = "Allow"
          protocol                    = "Tcp"
          source_port_range           = "*"
          destination_port_range      = "80"
          source_address_prefix       = "*"
          destination_address_prefix  = "*"
        },
        {
          name                        = "AllowHTTPS"
          priority                    = 101
          direction                   = "Inbound"
          access                      = "Allow"
          protocol                    = "Tcp"
          source_port_range           = "*"
          destination_port_range      = "443"
          source_address_prefix       = "*"
          destination_address_prefix  = "*"
        }
      ]
    },
    "db_nsg" = {
      name  = "db-nsg"
      rules = [
        {
          name                        = "AllowSQL"
          priority                    = 100
          direction                   = "Inbound"
          access                      = "Allow"
          protocol                    = "Tcp"
          source_port_range           = "*"
          destination_port_range      = "1433"
          source_address_prefix       = "*"
          destination_address_prefix  = "*"
        }
      ]
    }
  }
}


module "networking" {
  source                  = "../modules/Networking"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  virtual_networks        = var.virtual_networks
  subnets                 = var.subnet_blocks
  nsgs                    = local.nsg_configs  

}

module "networking1" {
  source                  = "../modules/Networking"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  virtual_networks        = var.virtual_networks
  subnets                 = var.subnet_blocks
  nsgs                    = local.nsg_configs  

}


// Use the created resource group in the networking module
# module "networking" {
#   source                  = "../modules/Networking"
#   resource_group_name     = azurerm_resource_group.resource_group.name  # Reference the resource group name here
#   resource_group_location = var.resource_group_location
#   virtual_networks        = var.virtual_networks
#   subnets                 = var.subnet_blocks
#   nsg_name                = var.nsg_name
#   nsg_rules               = var.security_rules
# }

// Pass the subnet IDs from the networking module to the virtual_machines module
module "virtual_machines" {
  source                  = "../modules/VirtualMachine"
  resource_group_name     = azurerm_resource_group.resource_group.name  # Reference the resource group name here
  resource_group_location = var.resource_group_location
  subnet_ids              = module.networking.subnet_ids
  nic_name                = var.nic_name
}
