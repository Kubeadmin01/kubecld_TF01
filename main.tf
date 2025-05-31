terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.26.0"
    }
  }



resource "azurerm_resource_group" "RG" {
  name     = "${var.environment}_tf01"
  location = var.allowed_locations[0]
}

module "VNET" {
  source                  = "./modules/VNET"
  resource_group_name     = azurerm_resource_group.RG.name
  resource_group_location = azurerm_resource_group.RG.location
  azurerm_subnet_name     = var.azurerm_subnet_name
  environment             = var.environment
  network_config          = var.network_config
  
}

module "Storageaccount" {
  source                   = "./modules/Storageaccount"
  resource_group_name      = azurerm_resource_group.RG.name
  resource_group_location  = azurerm_resource_group.RG.location
  azurerm_subnet_id        = module.VNET.pesn_subnet_id
  random_prefix            = var.random_prefix
}