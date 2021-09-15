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

    name      = join("-",[var.pRegion,"rg",var.pProject,var.pEnvironment])
    location  = var.pLocation
    tags      = var.ptags
}