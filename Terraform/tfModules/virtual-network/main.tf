resource "azurerm_virtual_network" "network" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
  #dns_servers         = var.dns_servers
  tags                = var.tags

  subnet {
    name           = var.subnet_name
    address_prefix = var.subnet_address_space
  }
}