resource "azurerm_application_insights" "appi" {
  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  tags                      = var.tags
  
  application_type          = var.application_type
}