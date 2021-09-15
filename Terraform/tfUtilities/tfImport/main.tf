terraform {
  backend "azurerm" {
        resource_group_name = var.tfInitiative+"-"+var.tfProject+"-rg"
        storage_account_name = var.tfInitiative+""+var.tfProject+"sa"
        container_name = var.tfbackendAzureRmContainerName
        key = var.pInitiative+"."+var.pProject+"."+var.pEnvironment+"."+var.pRegion+".tfstate"
  }
}

provider "azurerm" {
  #version = "~> 2.15"

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  features {}
}

#import storage account
module "storage_account" {  
    source    = "../../tfModules/storage-account"

    initiative = var.pInitiative
    project = var.pProject
    environment = var.pEnvironment
    region = var.pRegion
    tags = var.ptags
}