variable "resource_group_name" {
  description = "Name of the User Assigned Managed Identity resource group"
  type        = string
}

variable "location" {
  description = "Azure region of the User Assigned Managed Identity"
  type        = string
}

variable "name" {
  description = "The name of the User Assigned Managed Identity"
  type        = string
}

variable "tags" {
  type = map(string)
}