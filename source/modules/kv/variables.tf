# modules/vnet/hub/variables.tf

variable "prefix" {
  type        = string
  description = "Prefix differentiator"
}

variable "environment" {
  type        = string
  description = "Environment differentiator"
}

variable "location" {
  type        = string
  description = "Resource location"
}

variable "tags" {
  type        = map
  description = "Resource tags"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID"
}

variable "object_id" {
  type        = string
  description = "Object ID"
}
