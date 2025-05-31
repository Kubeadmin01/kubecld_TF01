variable "environment" {
  type        = string
  description = "environment type"
}

variable "allowed_locations" {
  type        = list(string)
  description = "list of allowed locations"
}



variable "network_config" {
  type = tuple([string, string, string, string, string, string, string, number])
}
variable "azurerm_subnet_name" {
  type = list(string)
}


variable "random_prefix" {
  type        = string
  description = "Random prefix for naming"
}