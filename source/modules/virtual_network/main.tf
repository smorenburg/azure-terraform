# Create virtual network hub and subnets
resource "azurerm_virtual_network" "vnet_hub" {
  name                = "${var.prefix}-${var.environment}-vnet-hub"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.hub_address_space
  dns_servers         = var.hub_dns_servers

  tags = var.tags
}

resource "azurerm_subnet" "vnet_hub_gatewaysubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefix       = var.hub_gatewaysubnet_address_prefix
}

resource "azurerm_subnet" "vnet_hub_firewallsubnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefix       = var.hub_firewallsubnet_address_prefix
}

resource "azurerm_subnet" "vnet_hub_defaultsubnet" {
  name                 = "defaultsubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefix       = var.hub_defaultsubnet_address_prefix
}

# Create network security group for default subnet
resource "azurerm_network_security_group" "vnet_hub_defaultsubnet_nsg" {
  name                = "${var.prefix}-${var.environment}-vnet-hub-defaultsubnet-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# Associate network security group with default subnet
resource "azurerm_subnet_network_security_group_association" "vnet_hub_defaultsubnet_nsg_assc" {
  subnet_id                 = azurerm_subnet.vnet_hub_defaultsubnet.id
  network_security_group_id = azurerm_network_security_group.vnet_hub_defaultsubnet_nsg.id
}

# Create first virtual network spoke and default subnet
resource "azurerm_virtual_network" "vnet_spoke01" {
  name                = "${var.prefix}-${var.environment}-vnet-spoke01"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.spoke01_address_space
  dns_servers         = var.spoke01_dns_servers

  tags = var.tags
}

resource "azurerm_subnet" "vnet_spoke01_defaultsubnet" {
  name                 = "defaultsubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_spoke01.name
  address_prefix       = var.spoke01_defaultsubnet_address_prefix
}

# Create network security group for default subnet
resource "azurerm_network_security_group" "vnet_spoke01_defaultsubnet_nsg" {
  name                = "${var.prefix}-${var.environment}-vnet-spoke01-defaultsubnet-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# Associate network security group with default subnet
resource "azurerm_subnet_network_security_group_association" "vnet_spoke01_defaultsubnet_nsg_assc" {
  subnet_id                 = azurerm_subnet.vnet_spoke01_defaultsubnet.id
  network_security_group_id = azurerm_network_security_group.vnet_spoke01_defaultsubnet_nsg.id
}

# Create bi-directional virtual network peering between hub and first spoke
resource "azurerm_virtual_network_peering" "vnet_hub_spoke01_peer" {
  name                         = "hub_spoke01"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.vnet_hub.name
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
  remote_virtual_network_id    = azurerm_virtual_network.vnet_hub.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false
}
