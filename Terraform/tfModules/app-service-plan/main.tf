resource "azurerm_app_service_plan" "asp" {
  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  tags                      = var.tags

  sku {
    tier                    = var.tier
    size                    = var.size
  }

  kind                      = var.kind
  reserved                  = var.kind == "Linux" ? true : null

  lifecycle {
    create_before_destroy   = true
  }
}