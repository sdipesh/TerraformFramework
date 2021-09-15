#Azure vars
variable "subscription_id" {
  type = string
}
variable "client_id" {
  type = string
}
variable "client_secret"{
  type = string
}
variable "tenant_id" {
  type = string
}

#terraform backend config vars
variable "tfInitiative" {
  type = string
}
variable "tfProject" {
  type = string
}
variable "tfEnvironment"{
  type = string
}
variable "tfbackendAzureRmContainerName" {
  type = string
}

#project specific vars
variable "ptags" {
  type = map(string)
}
variable "pInitiative" {
  type = string
}
variable "pProject" {
  type = string
}
variable "pEnvironment"{
  type = string
}
variable "pRegion" {
  type = string
}