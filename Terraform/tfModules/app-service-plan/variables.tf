variable "resource_group_name" {
  description = "Name of the App Service Plan resource group"
  type        = string
}

variable "location" {
  description = "Azure region of the App Service Plan"
  type        = string
}

variable "name" {
  description = "The name of the App Service Plan"
  type        = string
}

variable "tier" {
  description = "The tier of the App Service Plan"
  type        = string
}

variable "size" {
  description = "The size of the App Service Plan"
  type        = string
}

variable "kind" {
  description = "The kind of the App Service Plan (Windows/Linux)"
  type        = string
}

variable "tags" {
  type = map(string)
}