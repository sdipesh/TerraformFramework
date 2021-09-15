#resource "azuread_group" "aks_administrators" {
#  display_name        = join("-",[var.name,"administrators"])
#  description         = "Kubernetes administrators for the aks cluster."
#}