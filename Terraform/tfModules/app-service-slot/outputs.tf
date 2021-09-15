output "id" {  
    description = "id of the provisioned app service"  
    value = azurerm_app_service_slot.appserviceslot.id
} 
output "default_site_hostname" {
  value = azurerm_app_service_slot.appserviceslot.default_site_hostname
}
output "site_credential" {
  value = azurerm_app_service_slot.appserviceslot.site_credential
}