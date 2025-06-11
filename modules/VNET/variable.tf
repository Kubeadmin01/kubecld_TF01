variable "resource_group_name" {
  type = string
}
variable "resource_group_location" {
  type = string
}
variable "environment" {
  type = string
}
variable "network_config" {
  type = tuple([string, string, string, string, string, string, string, number])
}

variable "subnets" {
  description = "Map of subnet names to network_config index"
  type = map(object({
    index = number
  }))
}