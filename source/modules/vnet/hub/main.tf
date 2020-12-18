# modules/vnet/hub/main.tf

# Create virtual network and subnets
resource "azurerm_virtual_network" "vnet_hub" {
  name                = "${var.prefix}-${var.environment}-vnet-hub"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.hub_address_space
  dns_servers         = var.hub_dns_servers

  tags = var.tags
}

resource "azurerm_subnet" "vnet_hub_gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefix       = var.hub_gateway_address_prefix
}

resource "azurerm_subnet" "vnet_hub_firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefix       = var.hub_firewall_address_prefix
}

resource "azurerm_subnet" "vnet_hub_default" {
  name                 = "default"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet_hub.name
  address_prefix       = var.hub_default_address_prefix
}

# Create network security group for default subnet
resource "azurerm_network_security_group" "vnet_hub_default_nsg" {
  name                = "${var.prefix}-${var.environment}-vnet-hub-default-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# Associate network security group with default subnet
resource "azurerm_subnet_network_security_group_association" "vnet_hub_default_nsg_assc" {
  subnet_id                 = azurerm_subnet.vnet_hub_default.id
  network_security_group_id = azurerm_network_security_group.vnet_hub_default_nsg.id
}
