variable "subscription_id" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "client_id" {
  type = string
}
variable "client_secret" {
  type = string
}
variable "resource_group_name" {
  type = string
}
variable "location" {
  type = string
}
variable "address_space" {
  type = string
}
variable "address_prefixes" {
  type = string
}
variable "allocation_method" {
  type = string
}
variable "sku" {
  type = string
}
variable "sku_tier" {
  type = string
}
variable "http_port" {
  type = string
}
variable "https_port" {
  type = string
}
variable "ssh_port" {
  type = string
}
variable "tcp_protocol" {
  type = string
}
variable "packer_image_name" {
  type = string
}
variable "packer_image_version" {
  type = string
}
variable "image_publisher" {
  type = string
}
variable "image_offer" {
  type = string
}
variable "image_sku" {
  type = string
}
variable "image_version" {
  type = string
}
variable "instances" {
  type = number
}
variable "admin_username" {
  type = string
}
variable "public_key_path" {
  type = string
}
variable "upgrade_mode" {
  type = string
}
variable "storage_account_type" {
  type = string
}
variable "caching" {
  type = string
}
variable "nsg_rule_direction" {
  type = string
}
variable "nsg_rule_allow_access" {
  type = string
}
variable "nsg_rule_deny_access" {
  type = string
}
variable "domain_name" {
  type = string
}
variable "azure_tags" {
  type = object({
    environment = string
    projectname = string
    owner       = string
  })
}

locals {
  naming_convention = "${var.azure_tags.owner}-eastasia-${var.azure_tags.environment}-terraformproject"
}