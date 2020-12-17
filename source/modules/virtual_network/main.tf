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

resource "azurerm_network_security_group" "vnet_hub_defaultsubnet_nsg" {
  name                = "${var.prefix}-${var.environment}-vnet-hub-defaultsubnet-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "vnet_hub_defaultsubnet_nsg_assc" {
  subnet_id                 = azurerm_subnet.vnet_hub_defaultsubnet.id
  network_security_group_id = azurerm_network_security_group.vnet_hub_defaultsubnet_nsg.id
}
