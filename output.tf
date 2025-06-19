output "virtual_network_id" {
  description = "The id of the newly created vNet"
  value       = module.VNET.virtual_network_id
}

output "virtual_network_name" {
  description = "The Name of the newly created vNet"
  value       = module.VNET.virtual_network_name
}

output "storage_account_id" {
  description = "Azure Storage Account id."
  value       = module.Storageaccount.storage_account_id
}

output "storage_account_private_endpoint_id" {
  description = "Azure Storage Account Private Endpoint id"
  value       = module.Storageaccount.private_endpoint_id
}