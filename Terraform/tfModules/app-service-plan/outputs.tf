output "id" {  
    description = "id of the provisioned app service plan"  
    value = azurerm_app_service_plan.asp.id
} 
output "maximum_number_of_workers" {
  value = azurerm_app_service_plan.asp.maximum_number_of_workers
}