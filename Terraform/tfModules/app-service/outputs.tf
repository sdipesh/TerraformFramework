output "id" {  
  value = azurerm_app_service.appservice.id
} 
output "name" {   
  value = azurerm_app_service.appservice.name
} 
output "default_site_hostname" {
  value = azurerm_app_service.appservice.default_site_hostname
}
output "outbound_ip_addresses" {
  value = azurerm_app_service.appservice.outbound_ip_addresses
}
output "outbound_ip_address_list" {
  value = azurerm_app_service.appservice.outbound_ip_address_list
}
output "site_credential" {
  value = azurerm_app_service.appservice.site_credential
}
output "identity" {
  value = azurerm_app_service.appservice.identity
}