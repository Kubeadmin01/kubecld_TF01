terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.107"
    }
  
    
  }
  backend "azurerm" {
    resource_group_name  = "TF_State"              # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "tfstate030"            # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstatelock"           # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "dev.terraform.tfstate" # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
  required_version = ">= 1.3.0"
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
  subscription_id = "112c2c32-7cd1-45a4-bd96-b189e04d35c3"
}

provider "azurerm" {
  alias   = "connectivity"
  features {}
}

provider "azurerm" {
  alias   = "management"
  features {}
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

module "Keyvault" {
  source                   = "./modules/Keyvault"
  resource_group_name      = azurerm_resource_group.RG.name
  resource_group_location  = azurerm_resource_group.RG.location
  azurerm_subnet_id        = module.VNET.pesn_subnet_id
  random_prefix            = var.random_prefix
}

data "azurerm_client_config" "core" {}

module "ALZ_enterprise_scale" {
  source           = "Azure/caf-enterprise-scale/azurerm"
  version          = "6.2.0"
  default_location = var.default_location
  root_parent_id   = data.azurerm_client_config.core.tenant_id
  root_id          = var.root_id
  root_name        = var.root_name
  providers = {
    azurerm.connectivity = azurerm.connectivity
    azurerm.management   = azurerm.management
  }
}