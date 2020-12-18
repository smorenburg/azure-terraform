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

variable "hub_address_space" {
  type        = list
  description = "Virtual network hub address space"
}

variable "hub_dns_servers" {
  type        = list
  description = "Virtual network hub DNS servers"
}

variable "hub_gateway_address_prefix" {
  type        = string
  description = "Virtual network hub gateway subnet address prefix"
}

variable "hub_firewall_address_prefix" {
  type        = string
  description = "Virtual network hub firewall subnet address prefix"
}

variable "hub_default_address_prefix" {
  type        = string
  description = "Virtual network hub default subnet address prefix"
}
