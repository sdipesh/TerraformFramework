variable "resource_group_name" {
  description = "Name of the Application Insights resource group"
  type        = string
}

variable "location" {
  description = "Azure region of the Application Insights"
  type        = string
}

variable "name" {
  description = "The name of the Application Insights"
  type        = string
}

variable "application_type" {
  description = "The type of the Application Insights"
  type        = string
}

variable "tags" {
  type = map(string)
}