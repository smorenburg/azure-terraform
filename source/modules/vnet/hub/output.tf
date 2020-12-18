# modules/vnet/hub/output.tf

output "name" {
  value       = azurerm_virtual_network.vnet_hub.name
  description = "Virtual network hub name"
}

output "id" {
  value       = azurerm_virtual_network.vnet_hub.id
  description = "Virtual network hub ID"
}
