# modules/vnet/spoke01/variables.tf

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

variable "spoke01_address_space" {
  type        = list
  description = "Virtual network spoke address space"
}

variable "spoke01_dns_servers" {
  type        = list
  description = "Virtual network spoke DNS servers"
}

variable "spoke01_default_address_prefix" {
  type        = string
  description = "Virtual network spoke default subnet address prefix"
}

variable "hub_name" {
  type        = string
  description = "Virtual network hub name"
}

variable "hub_id" {
  type        = string
  description = "Virtual network hub ID"
}
