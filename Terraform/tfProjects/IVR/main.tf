terraform {
  backend "azurerm" {
        resource_group_name  = join("-",[var.pRegion,"rg",var.pProject,var.pEnvironment])
        storage_account_name = join("",[var.pRegion,"sa",var.pProject,var.pEnvironment])
        container_name       = var.tfbackendAzureRmContainerName
        key                  = join(".",[var.pRegion,var.pInitiative,var.pProject,var.pEnvironment,"tfstate"])
  }
}

provider "azurerm" {
  features {}
}

#create project specific resource group
module "resource_group" {  
    source    = "../../tfModules/resource-group"

    name      = join("-",[var.pRegion,var.pInitiative,var.pProject,"rg",var.pEnvironment])
    location  = var.pLocation
    tags      = var.ptags
}

#create project specific user assigned managed identity
module "user_assigned_managed_identity" {  
    source                = "../../tfModules/user-assigned-managed-identity"

    name                  = join("-",[var.pRegion,var.pInitiative,var.pProject,"mi",var.pEnvironment])
    location              = var.pLocation
    resource_group_name   = module.resource_group.name
    tags                  = var.ptags
}

#create application insights
module "application_insights" {  
    source                = "../../tfModules/application-insights"

    name                  = join("-",[var.pRegion,var.pInitiative,var.pProject,"appi",var.pEnvironment])
    location              = var.pLocation
    resource_group_name   = module.resource_group.name
    tags                  = var.ptags
    application_type      = "web"
}

#create project specific app service plan
module "app_service_plan" {  
    source                = "../../tfModules/app-service-plan"

    name                  = join("-",[var.pRegion,var.pInitiative,var.pProject,"asp",var.pEnvironment])
    location              = var.pLocation
    resource_group_name   = module.resource_group.name
    tags                  = var.ptags
    tier                  = var.app_service_plan_tier
    size                  = var.app_service_plan_size
    kind                  = "Windows"
}

#create project specific app service - frontend
module "frontend_app_service" {  
    source                                      = "../../tfModules/app-service"

    name                                        = join("-",[var.pRegion,var.pInitiative,var.pProject,"app",var.pEnvironment,"web"])
    location                                    = var.pLocation
    resource_group_name                         = module.resource_group.name
    tags                                        = var.ptags
    app_service_plan_id                         = module.app_service_plan.id
    auth_enabled                                = "true"
    auth_default_provider                       = "AzureActiveDirectory"
    auth_issuer                                 = format("https://login.microsoftonline.com/%s/", var.tenant_id)
    auth_client_id                              = var.auth_client_id_dev
    identity_type                               = "UserAssigned"
    user_assigned_managed_identities            = [module.user_assigned_managed_identity.id]
    APPINSIGHTS_INSTRUMENTATIONKEY              = module.application_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING       = module.application_insights.connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION  = "~2"
}

#create project specific app service slot
module "frontend_app_service_slot_dev" {  
    source                                      = "../../tfModules/app-service-slot"

    name                                        = "dev"
    location                                    = var.pLocation
    resource_group_name                         = module.resource_group.name
    tags                                        = var.ptags
    app_service_plan_id                         = module.app_service_plan.id
    app_service_name                            = module.frontend_app_service.name
    auth_enabled                                = "true"
    auth_default_provider                       = "AzureActiveDirectory"
    auth_issuer                                 = format("https://login.microsoftonline.com/%s/", var.tenant_id)
    auth_client_id                              = var.auth_client_id_dev
    identity_type                               = "UserAssigned"
    user_assigned_managed_identities            = [module.user_assigned_managed_identity.id]
    APPINSIGHTS_INSTRUMENTATIONKEY              = module.application_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING       = module.application_insights.connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION  = "~2"    
}

#create project specific app service slot
module "frontend_app_service_slot_qa" {  
    source                                      = "../../tfModules/app-service-slot"

    name                                        = "qa"
    location                                    = var.pLocation
    resource_group_name                         = module.resource_group.name
    tags                                        = var.ptags
    app_service_plan_id                         = module.app_service_plan.id
    app_service_name                            = module.frontend_app_service.name
    auth_enabled                                = "true"
    auth_default_provider                       = "AzureActiveDirectory"
    auth_issuer                                 = format("https://login.microsoftonline.com/%s/", var.tenant_id)
    auth_client_id                              = var.auth_client_id_qa
    identity_type                               = "UserAssigned"
    user_assigned_managed_identities            = [module.user_assigned_managed_identity.id]
    APPINSIGHTS_INSTRUMENTATIONKEY              = module.application_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING       = module.application_insights.connection_string    
    ApplicationInsightsAgent_EXTENSION_VERSION  = "~2"
}

#create project specific app service slot
module "frontend_app_service_slot_uat" {  
    source                                      = "../../tfModules/app-service-slot"

    name                                        = "uat"
    location                                    = var.pLocation
    resource_group_name                         = module.resource_group.name
    tags                                        = var.ptags
    app_service_plan_id                         = module.app_service_plan.id
    app_service_name                            = module.frontend_app_service.name
    auth_enabled                                = "true"
    auth_default_provider                       = "AzureActiveDirectory"
    auth_issuer                                 = format("https://login.microsoftonline.com/%s/", var.tenant_id)
    auth_client_id                              = var.auth_client_id_uat
    identity_type                               = "UserAssigned"
    user_assigned_managed_identities            = [module.user_assigned_managed_identity.id]
    APPINSIGHTS_INSTRUMENTATIONKEY              = module.application_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING       = module.application_insights.connection_string   
    ApplicationInsightsAgent_EXTENSION_VERSION  = "~2"
}

#create project specific app service - backend api
module "backend_app_service" {  
    source                                      = "../../tfModules/app-service"

    name                                        = join("-",[var.pRegion,var.pInitiative,var.pProject,"app",var.pEnvironment,"api"])
    location                                    = var.pLocation
    resource_group_name                         = module.resource_group.name
    tags                                        = var.ptags
    app_service_plan_id                         = module.app_service_plan.id
    auth_enabled                                = "true"
    auth_default_provider                       = "AzureActiveDirectory"
    auth_issuer                                 = format("https://login.microsoftonline.com/%s/", var.tenant_id)
    auth_client_id                              = var.auth_client_id_dev
    identity_type                               = "UserAssigned"
    user_assigned_managed_identities            = [module.user_assigned_managed_identity.id]
    APPINSIGHTS_INSTRUMENTATIONKEY              = module.application_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING       = module.application_insights.connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION  = "~2"
}

#create project specific app service slot
module "backend_app_service_slot_dev" {  
    source                                      = "../../tfModules/app-service-slot"

    name                                        = "dev"
    location                                    = var.pLocation
    resource_group_name                         = module.resource_group.name
    tags                                        = var.ptags
    app_service_plan_id                         = module.app_service_plan.id
    app_service_name                            = module.backend_app_service.name
    auth_enabled                                = "true"
    auth_default_provider                       = "AzureActiveDirectory"
    auth_issuer                                 = format("https://login.microsoftonline.com/%s/", var.tenant_id)
    auth_client_id                              = var.auth_client_id_dev
    identity_type                               = "UserAssigned"
    user_assigned_managed_identities            = [module.user_assigned_managed_identity.id]
    APPINSIGHTS_INSTRUMENTATIONKEY              = module.application_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING       = module.application_insights.connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION  = "~2"
}

#create project specific app service slot
module "backend_app_service_slot_qa" {  
    source                                      = "../../tfModules/app-service-slot"

    name                                        = "qa"
    location                                    = var.pLocation
    resource_group_name                         = module.resource_group.name
    tags                                        = var.ptags
    app_service_plan_id                         = module.app_service_plan.id
    app_service_name                            = module.backend_app_service.name
    auth_enabled                                = "true"
    auth_default_provider                       = "AzureActiveDirectory"
    auth_issuer                                 = format("https://login.microsoftonline.com/%s/", var.tenant_id)
    auth_client_id                              = var.auth_client_id_qa
    identity_type                               = "UserAssigned"
    user_assigned_managed_identities            = [module.user_assigned_managed_identity.id]
    APPINSIGHTS_INSTRUMENTATIONKEY              = module.application_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING       = module.application_insights.connection_string
    ApplicationInsightsAgent_EXTENSION_VERSION  = "~2"
}

#create project specific app service slot
module "backend_app_service_slot_uat" {  
    source                                      = "../../tfModules/app-service-slot"

    name                                        = "uat"
    location                                    = var.pLocation
    resource_group_name                         = module.resource_group.name
    tags                                        = var.ptags
    app_service_plan_id                         = module.app_service_plan.id
    app_service_name                            = module.backend_app_service.name
    auth_enabled                                = "true"
    auth_default_provider                       = "AzureActiveDirectory"
    auth_issuer                                 = format("https://login.microsoftonline.com/%s/", var.tenant_id)
    auth_client_id                              = var.auth_client_id_uat
    identity_type                               = "UserAssigned"
    user_assigned_managed_identities            = [module.user_assigned_managed_identity.id]
    APPINSIGHTS_INSTRUMENTATIONKEY              = module.application_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING       = module.application_insights.connection_string   
    ApplicationInsightsAgent_EXTENSION_VERSION  = "~2"
}

#Add user assigned managed identity to key vault access policy
#module "key_vault_access_policy" {
#    source                          = "../../tfModules/key-vault-access-policy"

#    key_vault_id                    = var.key_vault_id
#    tenant_id                       = var.tenant_id
#    managed_identity_object_id      = module.user_assigned_managed_identity.principal_id
#    secret_permissions              = var.secret_permissions
#}