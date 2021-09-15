resource "azurerm_storage_account" "storage" {
  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  account_kind              = var.kind
  account_tier              = var.tier
  account_replication_type  = var.replication_type
  access_tier               = var.access_tier
  enable_https_traffic_only = true
  tags = var.tags
}