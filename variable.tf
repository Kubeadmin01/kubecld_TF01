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



variable "random_prefix" {
  type        = string
  description = "Random prefix for naming"
}

variable "root_id" {
  type        = string
  description = "The ID of the root resource"
}

variable "root_name" {
  type        = string
  description = "The name of the root resource"
}

variable "default_location" {
  type        = string
  description = "The default location for resources"
}
variable "root_tags" {
  type        = map(string)
  description = "Tags to be applied to the root resource"
  default     = {}
}


