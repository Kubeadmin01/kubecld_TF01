# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.107"
    }
  }
}

# You can use the azurerm_client_config data resource to dynamically
# extract connection settings from the provider configuration.

data "azurerm_client_config" "core" {}

# Call the caf-enterprise-scale module directly from the Terraform Registry
# pinning to the latest version

module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "~> 6.2.0" # change this to your desired version, https://www.terraform.io/language/expressions/version-constraints

  default_location = var.default_location

  root_parent_id = data.azurerm_client_config.core.tenant_id
  root_id        = var.root_id
  root_name      = var.root_name

  deploy_connectivity_resources = true
  subscription_id_connectivity  = data.azurerm_client_config.core.subscription_id

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm.connectivity
    azurerm.management   = azurerm.management
  }
}
resource "azurerm_policy_assignment" "enforce_encryption_cmk" {
  name                 = "Enforce-Encryption-CMK"
  display_name         = "Enforce Encryption using CMK"
  policy_definition_id = azurerm_policy_set_definition.enforce_encryption_cmk.id
  scope                = var.management_group_id

  parameters = jsonencode({
    effect = {
      value = "AuditIfNotExists" # or "Disabled" based on your requirement
    }
  })
}