resource "azurerm_public_ip" "azure-public-ip" {
  name                = "loadbalancer-ip-${local.naming_convention}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method
  sku                 = var.sku
  tags = {
    environment = var.azure_tags.environment
    projectname = var.azure_tags.projectname
    owner       = var.azure_tags.owner
  }
}

resource "azurerm_lb" "azure-loadbalancer" {
  name                = "loadbalancer-${local.naming_convention}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  sku_tier            = var.sku_tier
  frontend_ip_configuration {
    name                 = azurerm_public_ip.azure-public-ip.name
    public_ip_address_id = azurerm_public_ip.azure-public-ip.id
  }
  tags = {
    environment = var.azure_tags.environment
    projectname = var.azure_tags.projectname
    owner       = var.azure_tags.owner
  }
  depends_on = [
    azurerm_public_ip.azure-public-ip
  ]
}

resource "azurerm_lb_backend_address_pool" "azure-backend-pool" {
  name            = "backend-pool-${local.naming_convention}"
  loadbalancer_id = azurerm_lb.azure-loadbalancer.id
  depends_on = [
    azurerm_lb.azure-loadbalancer
  ]
}

resource "azurerm_lb_probe" "azure-http-probe" {
  name            = "http-health-probe-${local.naming_convention}"
  loadbalancer_id = azurerm_lb.azure-loadbalancer.id
  port            = var.http_port
  protocol        = var.tcp_protocol
  depends_on = [
    azurerm_lb.azure-loadbalancer
  ]
}

resource "azurerm_lb_rule" "azure-lbrule-1" {
  name                           = "lbrule-1-${local.naming_convention}"
  loadbalancer_id                = azurerm_lb.azure-loadbalancer.id
  protocol                       = var.tcp_protocol
  frontend_port                  = var.http_port
  backend_port                   = var.http_port
  frontend_ip_configuration_name = azurerm_public_ip.azure-public-ip.name
  probe_id                       = azurerm_lb_probe.azure-http-probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.azure-backend-pool.id]
  depends_on = [
    azurerm_lb.azure-loadbalancer
  ]
}