resource "azurerm_app_service_slot" "appserviceslot" {
  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  app_service_plan_id       = var.app_service_plan_id
  client_affinity_enabled   = var.client_affinity_enabled
  tags                      = var.tags
  app_service_name          = var.app_service_name

  auth_settings {
      enabled           = var.auth_enabled
      default_provider  = var.auth_default_provider
      issuer            = var.auth_issuer
      active_directory {
          client_id     = var.auth_client_id
      }
  }

  app_settings = {
        "APPINSIGHTS_INSTRUMENTATIONKEY" = var.APPINSIGHTS_INSTRUMENTATIONKEY
        "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.APPLICATIONINSIGHTS_CONNECTION_STRING
        "ApplicationInsightsAgent_EXTENSION_VERSION"  = var.ApplicationInsightsAgent_EXTENSION_VERSION 
  }

  identity {
      type = var.identity_type
      identity_ids = var.user_assigned_managed_identities
  }

  site_config {
    always_on                   = var.always_on
  }
}