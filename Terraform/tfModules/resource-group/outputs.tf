output "id" {  
    description = "id of the resource group provisioned"  
    value = "azurerm_resource_group.rg.id"  
} 
output "name" {
  value = azurerm_resource_group.rg.name
}
output "location" {
  value = azurerm_resource_group.rg.location
}