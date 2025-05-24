variable "environment" {
  type        = string
  description = "environment type"
}
variable "allowed_locations" {
  type        = list(string)
  description = "list of allowed locations"
}
# Tuple type
variable "network_config" {
  type = tuple([string, string, string, string, string, string, string, number])
  description = "Network configuration (VNET address, subnet address, subnet mask)"
}
variable "azurerm_subnet_name" {
  type = list(string)
  description = "list of subnet names "
}

variable "SA" {
  description = "storage account name"
  type        = string
}
variable "azurerm_private_endpoint" {
  type        = string
  description = "private endpoint name associated with storage account"
}
variable "storage_account_location" {
  type        = string
  description = "storage account location"
}
variable "random_prefix" {
  type = string
  description = "random prefix"
}
variable "azurerm_PE_subnet_name" {
  type = string
  description = "list of subnet names "
}

