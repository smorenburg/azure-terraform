# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-${var.environment}-rg"
  location = var.location

  tags = var.tags
}
