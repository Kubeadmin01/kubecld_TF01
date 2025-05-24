output "virtual_network__address_space" {
  description = "The address space of the newly created vNet"
  value       = azurerm_virtual_network.vnet.address_space
}

output "virtual_network__guid" {
  description = "The GUID of the newly created vNet"
  value       = azurerm_virtual_network.vnet.guid
}

output "virtual_network_id" {
  description = "The id of the newly created vNet"
  value       = azurerm_virtual_network.vnet.id
}

output "virtual_network_location" {
  description = "The location of the newly created vNet"
  value       = azurerm_virtual_network.vnet.location
}

output "virtual_network_name" {
  description = "The Name of the newly created vNet"
  value       = azurerm_virtual_network.vnet.name
}
output "azurerm_subnet_id" {
  description = "The Name of the newly created vNet"
  value       = azurerm_subnet.pesn.id
}


output "root_storage_account_private_endpoint_id" {
  description = "Azure Storage Account Private Endpoint id"
  value       = module.Storageaccount.storage_account_private_endpoint_id
}

output "root_storage_account_private_endpoint_name" {
  description = "Azure Storage Account Private Endpoint name"
  value       = module.Storageaccount.storage_account_private_endpoint_name
}
output "root_resource_group_name" {
  description = "Azure Resource Group name"
  value       = module.Storageaccount.resource_group_name
}
output "root_resource_group_location" {
  description = "Azure Resource Group location"
  value       = module.Storageaccount.resource_group_location
}

output "root_storage_account_id" {
  description = "Azure Storage Account id."
  value       = module.Storageaccount.storage_account_id
}
output "root_storage_account_location" {
  description = "Azure Storage Account location"
  value       = module.Storageaccount.storage_account_location
}
output "root_storage_account_name" {
  description = "Azure Storage Account name"
  value       = module.Storageaccount.storage_account_name
}

output "root_azurerm_subnet_name" {
  description = "The Name of the newly created vNet"
  value       = module.Storageaccount.azurerm_subnet_name
}
output "root_azurerm_subnet_id" {
  description = "The Name of the newly created vNet"
  value       = module.Storageaccount.azurerm_subnet_id
}
output "root_azurerm_vnet_id" {
  description = "The Name of the newly created vNet"
  value       = module.Storageaccount.azurerm_vnet_id
}
output "root_azurerm_vnet_name" {
  description = "The Name of the newly created vNet"
  value       = module.Storageaccount.azurerm_vnet_name
}
output "root_random_pet_prefix" {
  description = "The Name of the newly created vNet"
  value       = module.Storageaccount.random_pet_prefix
}