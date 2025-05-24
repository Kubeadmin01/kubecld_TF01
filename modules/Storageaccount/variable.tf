

variable "azurerm_private_endpoint" {
  type = string
  description = "private endpoint name associated with storage account"
}


variable "SA" {
  description = "storage account name"
  type = string
}


variable "azurerm_PE_subnet_name" {
  type = string
  description = "list of subnet names "
}
variable "storage_account_location" {
  type = string
  description = "azure storage account location"
}

variable "random_prefix" {
  type = string
  description = "random prefix"
}






