output "id" {
  value = azurerm_user_assigned_identity.userassignedmanagedidentity.id
}
output "principal_id" {
  value = azurerm_user_assigned_identity.userassignedmanagedidentity.principal_id
}
output "client_id" {
  value = azurerm_user_assigned_identity.userassignedmanagedidentity.client_id
}