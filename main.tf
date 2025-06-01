terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.26.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "TF_State"              # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "tfstate030"            # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstatelock"           # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "dev.terraform.tfstate" # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
  required_version = ">=1.10.0"
}

provider "azurerm" {
  features {}
  subscription_id = "112c2c32-7cd1-45a4-bd96-b189e04d35c3"
}

resource "azurerm_resource_group" "RG" {
  name     = "${var.environment}_tf01"
  location = var.allowed_locations[0]
}

module "VNET" {
  source                  = "./modules/VNET"
  resource_group_name     = azurerm_resource_group.RG.name
  resource_group_location = azurerm_resource_group.RG.location
  environment             = var.environment
  network_config          = var.network_config
  subnets = {
    pesn = { index = 6 }
  }
}

module "Storageaccount" {
  source                   = "./modules/Storageaccount"
  resource_group_name      = azurerm_resource_group.RG.name
  resource_group_location  = azurerm_resource_group.RG.location
  azurerm_subnet_id        = module.VNET.pesn_subnet_id
  random_prefix            = var.random_prefix
}