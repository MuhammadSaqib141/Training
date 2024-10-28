
resource "azurerm_ssh_public_key" "mysshkey_new" {
  name                = "my_ssh_key_new"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  public_key          = file("/home/muhammad/.ssh/my_ssh_key.pub")
}
resource "azurerm_lb" "example" {
  name                = var.lb_config.lb_name
  location            = var.lb_config.location
  resource_group_name = var.lb_config.resource_group_name

  frontend_ip_configuration {
    name                 = var.lb_config.frontend_ip_name
    public_ip_address_id = var.lb_config.public_ip_address_id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.example.id
  name            = var.lb_config.backend_pool_name
}

resource "azurerm_lb_nat_pool" "nat_pool" {
  resource_group_name            = var.lb_config.resource_group_name
  name                           = var.lb_config.nat_pool_name
  loadbalancer_id                = azurerm_lb.example.id
  protocol                       = var.lb_config.nat_pool_protocol
  frontend_port_start            = var.lb_config.nat_pool_frontend_port_start
  frontend_port_end              = var.lb_config.nat_pool_frontend_port_end
  backend_port                   = var.lb_config.nat_pool_backend_port
  frontend_ip_configuration_name = var.lb_config.frontend_ip_name
}

resource "azurerm_lb_probe" "probe" {
  loadbalancer_id = azurerm_lb.example.id
  name            = var.lb_config.probe_name
  protocol        = var.lb_config.probe_protocol
  request_path    = var.lb_config.probe_request_path
  port            = var.lb_config.probe_port
}

resource "azurerm_lb_rule" "example" {
  loadbalancer_id                = azurerm_lb.example.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = "PublicIPAddressForLB"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]
  probe_id = azurerm_lb_probe.probe.id
  
}

resource "azurerm_linux_virtual_machine_scale_set" "scale_set" {
  name                = var.vmss_config.name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = var.vmss_config.sku
  instances           = var.vmss_config.instance_count
  admin_username      = var.vmss_config.admin_username

  

  admin_ssh_key {
    username   = var.vmss_config.admin_username
    public_key = azurerm_ssh_public_key.mysshkey_new.public_key
  }

  source_image_reference {
    publisher = var.vmss_config.source_image_reference.publisher
    offer     = var.vmss_config.source_image_reference.offer
    sku       = var.vmss_config.source_image_reference.sku
    version   = var.vmss_config.source_image_reference.version
  }

  os_disk {
    storage_account_type = var.vmss_config.os_disk.storage_account_type
    caching              = var.vmss_config.os_disk.caching
  }

  network_interface {
    name    = var.vmss_config.nic_name
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.vmss_config.subnet_id
    load_balancer_backend_address_pool_ids    = [azurerm_lb_backend_address_pool.backend_pool.id]
      load_balancer_inbound_nat_rules_ids       = [azurerm_lb_nat_pool.nat_pool.id]
    }
  }

  custom_data = filebase64("/home/muhammad/Training/8_terraform/6_lb/modules/LoadBalancer/install_nginx.sh")

  depends_on =  [ 
                    azurerm_lb_backend_address_pool.backend_pool,
                    azurerm_lb_nat_pool.nat_pool
                ]
}