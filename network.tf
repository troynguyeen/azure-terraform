resource "azurerm_virtual_network" "azure-vnet" {
  name                = "vnet-${local.naming_convention}"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = [var.address_space]
  tags = {
    environment = var.azure_tags.environment
    projectname = var.azure_tags.projectname
    owner       = var.azure_tags.owner
  }
}

resource "azurerm_subnet" "azure-subnet" {
  name                 = "default"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.azure-vnet.name
  address_prefixes     = [var.address_prefixes]
  depends_on = [
    azurerm_virtual_network.azure-vnet
  ]
}

resource "azurerm_network_security_group" "azure-nsg" {
  name                = "nsg-${local.naming_convention}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags = {
    environment = var.azure_tags.environment
    projectname = var.azure_tags.projectname
    owner       = var.azure_tags.owner
  }
}

resource "azurerm_network_security_rule" "azure-nsg-http-rule" {
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.azure-nsg.name
  name                        = "AllowHTTP"
  priority                    = 100
  direction                   = var.nsg_rule_direction
  access                      = var.nsg_rule_allow_access
  protocol                    = var.tcp_protocol
  source_port_range           = "*"
  destination_port_range      = var.http_port
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

resource "azurerm_network_security_rule" "azure-nsg-https-rule" {
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.azure-nsg.name
  name                        = "AllowHTTPS"
  priority                    = 200
  direction                   = var.nsg_rule_direction
  access                      = var.nsg_rule_allow_access
  protocol                    = var.tcp_protocol
  source_port_range           = "*"
  destination_port_range      = var.https_port
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
}

resource "azurerm_subnet_network_security_group_association" "azure-nsg-association" {
  subnet_id                 = azurerm_subnet.azure-subnet.id
  network_security_group_id = azurerm_network_security_group.azure-nsg.id
}