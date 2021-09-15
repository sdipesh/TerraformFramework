variable "key_vault_id" {
  type        = string
}
variable "tenant_id" {
  type        = string
}
variable "managed_identity_object_id" {
  type        = string
}
variable "key_permissions" {
  type        = list(string)
  default     = []
}
variable "secret_permissions" {
  type        = list(string)
  default     = []  
}
variable "certificate_permissions" {
  type        = list(string)
  default     = []  
}
variable "storage_permissions" {
  type        = list(string)
  default     = []  
}