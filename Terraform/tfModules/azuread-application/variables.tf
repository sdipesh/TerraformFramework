variable "display_name" {
  description = "Display Name of the AD Application"
  type        = string
}

variable "reply_urls" {
  description = "Display Name of the AD Application"
  type        = list(string)
  default     = []
}