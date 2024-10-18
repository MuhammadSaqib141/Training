resource "azurerm_resource_group" "saqib_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "saqib_vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.saqib_rg.name
  location            = azurerm_resource_group.saqib_rg.location
  address_space       = var.address_space

  depends_on = [
    azurerm_resource_group.saqib_rg
  ]
}

resource "azurerm_subnet" "saqib_vnet_subnetA" {
  name                 = var.saqib_vnet_subnetA
  resource_group_name  = azurerm_resource_group.saqib_rg.name
  virtual_network_name = azurerm_virtual_network.saqib_vnet.name
  address_prefixes     = ["10.0.0.0/24"]
  depends_on = [ azurerm_virtual_network.saqib_vnet ]
}

resource "azurerm_subnet" "saqib_vnet_subnetB" {
  name                 = var.saqib_vnet_subnetB
  resource_group_name  = azurerm_resource_group.saqib_rg.name
  virtual_network_name = azurerm_virtual_network.saqib_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on = [ azurerm_virtual_network.saqib_vnet ]
}

resource "azurerm_network_security_group" "test_nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = azurerm_resource_group.saqib_rg.name

  depends_on = [azurerm_resource_group.saqib_rg]
}

resource "azurerm_network_security_rule" "test_rule1" {
  name                        = var.nsg_rule_name
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.saqib_rg.name
  network_security_group_name = azurerm_network_security_group.test_nsg.name

  depends_on = [  azurerm_network_security_group.test_nsg ]
}


resource "azurerm_subnet_network_security_group_association" "azurerm_subnet_network_security_group_association" {
  subnet_id                 = azurerm_subnet.saqib_vnet_subnetB.id
  network_security_group_id = azurerm_network_security_group.test_nsg.id

  depends_on = [
    azurerm_subnet.saqib_vnet_subnetB,
    azurerm_network_security_group.test_nsg
  ]
}

resource "azurerm_network_interface_security_group_association" "azurerm_network_interface_security_group_association" {
  network_interface_id      = azurerm_network_interface.linuxvm_nic.id
  network_security_group_id = azurerm_network_security_group.test_nsg.id

  depends_on = [
    azurerm_network_interface.linuxvm_nic,
    azurerm_network_security_group.test_nsg
  ]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "public_ip"
  resource_group_name = azurerm_resource_group.saqib_rg.name
  location            = azurerm_resource_group.saqib_rg.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "linuxvm_nic" {
  name                = "linuxvm_nic"
  location            = azurerm_resource_group.saqib_rg.location
  resource_group_name = azurerm_resource_group.saqib_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.saqib_vnet_subnetB.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }

  depends_on = [
    azurerm_subnet.saqib_vnet_subnetB,
    azurerm_public_ip.public_ip
  ]
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                = "test-machine"
  resource_group_name = azurerm_resource_group.saqib_rg.name
  location            = azurerm_resource_group.saqib_rg.location
  size                = "Standard_F2"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.linuxvm_nic.id
  ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  depends_on = [
    azurerm_network_interface.linuxvm_nic,
    azurerm_public_ip.public_ip,
    azurerm_network_security_group.test_nsg
  ]
}


resource "azurerm_storage_account" "storage_account" {
  name                     = "msstorageaccount001234"
  resource_group_name      = azurerm_resource_group.saqib_rg.name
  location                 = azurerm_resource_group.saqib_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [ azurerm_resource_group.saqib_rg ]
}

resource "azurerm_storage_container" "scripts" {
  name                  = "scripts"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "container"

  depends_on = [ azurerm_storage_account.storage_account ]
}

resource "azurerm_storage_blob" "wordpress_script_blob" {
  name                   = "wordpress.sh"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.scripts.name
  type                   = "Block"
  source                 = "/home/muhammad/Training/8_terraform/2_vm_creation/wordpress.sh"

  depends_on = [azurerm_storage_container.scripts    ]
}

# data "azurerm_storage_account_sas" "sas_token" {
#   connection_string = azurerm_storage_account.storage_account.primary_connection_string
#   https_only = true
#   start  = "2024-03-21T00:00:00Z"
#   expiry = "2025-03-21T00:00:00Z"

#   permissions {
#     read    = true
#     write   = false
#     delete  = false
#     list    = false
#     add     = false
#     create  = false
#     update  = false
#     process = false
#     tag = true
#     filter = true
#   }

#   resource_types {
#     service   = false
#     container = false
#     object    = true
#   }

#   services {
#     blob  = true
#     queue = false
#     table = false
#     file  = false
#   }
# }


resource "azurerm_virtual_machine_extension" "linux_vm_custom_script" {
  name                 = "linuxCustomScriptExtension"
  virtual_machine_id   = azurerm_linux_virtual_machine.linux_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "fileUris": [
            "${azurerm_storage_blob.wordpress_script_blob.url}"
        ],
        "commandToExecute": "bash wordpress.sh install"
    }
  SETTINGS

  depends_on = [
    azurerm_linux_virtual_machine.linux_vm,
    azurerm_storage_blob.wordpress_script_blob
  ]
}