#terraform backend config vars
variable "tfRegion" {
  type = string
}
variable "tfProject" {
  type = string
}

variable "tfbackendAzureRmContainerName" {
  type = string
}

#project specific vars
variable "ptags" {
  type = map(string)
}
variable "pRegion" {
  type = string
}
variable "pProject" {
  type = string
}
variable "pEnvironment"{
  type = string
}
variable "pLocation" {
  type = string
}
variable "app_service_plan_tier" {
  description = "Tier of App Service Plan"
  default     = "Free"
  type = string
}
variable "app_service_plan_size" {
  description = "Size of App Service Plan"
  default     = "F1"
  type = string
}
variable "tenant_id" {
  description = "Tenant Id"
  type = string
}
variable "auth_client_id_dev" {
  description = "App Service Client Id for authentication - Dev"
  type = string
}
variable "auth_client_id_qa" {
  description = "App Service Client Id for authentication - QA"
  type = string
}
variable "auth_client_id_uat" {
  description = "App Service Client Id for authentication - UAT"
  type = string
}

variable "client_secret" {
  type = string
  default = ""
}

variable "client_id" {
  type = string
  default = ""
}

variable "subscription_id" {
  type = string
  default = ""
}

#variable "key_vault_id" {
#  type = string
#}

variable "secret_permissions" {
  type = list(string)
}