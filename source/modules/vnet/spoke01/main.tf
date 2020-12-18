# modules/vnet/spoke01/main.tf

# Create virtual network and default subnet
resource "azurerm_virtual_network" "vnet_spoke01" {
  name                = "${var.prefix}-${var.environment}-vnet-spoke01"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.spoke01_address_space
  dns_servers         = var.spoke01_dns_servers

  tags = var.tags
}

resource "azurerm_subnet" "vnet_spoke01_default" {
  name                 = "default"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_spoke01.name
  address_prefix       = var.spoke01_default_address_prefix
}

# Create network security group for default subnet
resource "azurerm_network_security_group" "vnet_spoke01_default_nsg" {
  name                = "${var.prefix}-${var.environment}-vnet-spoke01-default-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# Associate network security group with default subnet
resource "azurerm_subnet_network_security_group_association" "vnet_spoke01_default_nsg_assc" {
  subnet_id                 = azurerm_subnet.vnet_spoke01_default.id
  network_security_group_id = azurerm_network_security_group.vnet_spoke01_default_nsg.id
}

# Create bi-directional virtual network peering
resource "azurerm_virtual_network_peering" "vnet_hub_spoke01_peer" {
  name                         = "hub_spoke01"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.hub_name
  remote_virtual_network_id    = azurerm_virtual_network.vnet_spoke01.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "vnet_spoke01_hub_peer" {
  name                         = "spoke01_hub"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.vnet_spoke01.name
  remote_virtual_network_id    = var.hub_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false
}
