
output "storage_account_id" {
  description = "Azure Storage Account id."
  value       = azurerm_storage_account.SA.id
}
output "storage_account_location" {
  description = "Azure Storage Account location"
  value       = azurerm_storage_account.SA.location
}
output "storage_account_name" {
  description = "Azure Storage Account name"
  value       = azurerm_storage_account.SA.name
}
output "storage_account_private_endpoint_id" {
  description = "Azure Storage Account Private Endpoint id"
  value       = azurerm_private_endpoint.PE.id
}

output "storage_account_private_endpoint_name" {
  description = "Azure Storage Account Private Endpoint name"
  value       = azurerm_private_endpoint.PE.name
}
output "azurerm_subnet_id" {
  description = "Azure Subnet id"
  value       = azurerm_subnet.PE_subnet.id
}
output "azurerm_subnet_name" {
  description = "Azure Subnet name"
  value       = azurerm_subnet.PE_subnet.name
}
output "azurerm_vnet_id" {
  description = "The id of the newly created vNet"
  value       = azurerm_virtual_network.Kube_network.id
}
output "azurerm_vnet_name" {
  description = "The Name of the newly created vNet"
  value       = azurerm_virtual_network.Kube_network.name
}
output "azurerm_nat_gateway" {
  description = "The Name of the newly created nat gateway"
  value       = azurerm_nat_gateway.kube_nat_gateway
}
output "random_pet_prefix" {
  description = "random id along with prefix"
  value       = random_pet.prefix.id
}
output "resource_group_name" {
  description = "Resource group name used for the storage account"
  value       = azurerm_storage_account.SA.resource_group_name
}

output "resource_group_location" {
  description = "Location of the resource group used for the storage account"
  value       = azurerm_storage_account.SA.location
}
