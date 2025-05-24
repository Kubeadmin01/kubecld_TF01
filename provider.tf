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


