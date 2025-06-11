output "virtual_network__address_space" {
  description = "The address space of the newly created vNet"
  value       = azurerm_virtual_network.vnet.address_space
}

output "virtual_network_guid" {
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
output "pesn_subnet_id" {
  description = "The id of the private endpoint subnet"
  value       = azurerm_subnet.subnets["pesn"].id
}

