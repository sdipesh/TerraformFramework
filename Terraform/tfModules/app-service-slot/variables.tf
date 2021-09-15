variable "resource_group_name" {
  description = "Name of the App Service resource group"
  type        = string
}

variable "location" {
  description = "Azure region of the App Service"
  type        = string
}

variable "name" {
  description = "The name of the App Service"
  type        = string
}

variable "app_service_plan_id" {
  description = "The id of the App Service Plan"
  type        = string
}

variable "app_service_name" {
  description = "The name of App Service"
  type        = string
}

variable "auth_enabled" {
  description = "Specify if authentication is enabled on the App Service"
  type        = string
}

variable "auth_default_provider" {
  description = "Specify default provider for authentication"
  type        = string
}

variable "auth_issuer" {
  description = "Specify the authentication issuer"
  type        = string
}

variable "auth_client_id" {
  description = "Specify client id used for authentication"
  type        = string
}

variable "identity_type" {
  description = "Specify identity type (SystemAssigned or UserAssigned)"
  type        = string
}

variable "user_assigned_managed_identities" {
  description = "Specify list of user assigned identities"
  type        = list(string)
}

variable "APPINSIGHTS_INSTRUMENTATIONKEY" {
  description = "Specify instrumentation key of applicaiton insights"
  type        = string
}

variable "APPLICATIONINSIGHTS_CONNECTION_STRING" {
  description = "Specify connection string of application insights"
  type        = string
}

variable "ApplicationInsightsAgent_EXTENSION_VERSION" {
  description = "Specify extension version of application insights"
  type        = string
}

variable "always_on" {
  type        = string
  default     = "true"
}

variable "client_affinity_enabled" {
  type        = string
  default     = "true"
}

variable "tags" {
  type = map(string)
}