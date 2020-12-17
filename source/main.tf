# Terrafrom configuration
terraform {
  backend "azurerm" {
    resource_group_name  = "global-rg"
    storage_account_name = "statesa87392"
    container_name       = "tfstate"
    key                  = "dev.terraform.state"
  }
}

# Provider configuration
provider azurerm {
  version         = "2.0.0"
  subscription_id = var.subscription_id

  features {}
}

# Create resource group
module "resource_group" {
  source = "./modules/resource_group"

  prefix      = var.prefix
  environment = var.environment
  location    = var.location
  tags        = var.tags
}

# Create one hub virtual network with two spokes
module "virtual_network" {
  source = "./modules/virtual_network"

  prefix      = var.prefix
  environment = var.environment
  location    = var.location
  tags        = var.tags

  resource_group_name               = module.resource_group.name
  hub_address_space                 = ["10.0.0.0/22"]
  hub_dns_servers                   = ["8.8.8.8", "8.8.4.4"]
  hub_gatewaysubnet_address_prefix  = "10.0.0.0/26"
  hub_firewallsubnet_address_prefix = "10.0.0.64/26"
  hub_defaultsubnet_address_prefix  = "10.0.1.0/24"
}
