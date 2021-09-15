resource "azurerm_container_registry" "acr" {
  name                     = var.name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  sku                      = var.sku
  admin_enabled            = var.admin_enabled
  georeplication_locations = var.geo_replication
}