variable subscription_id {
  type = string
}
variable tenant_id {
  type = string
}
variable client_id {
  type = string
}
variable client_secret {
  type = string
}
variable primary_location {
  type = string
}
variable image_name {
  type = string
}
variable image_version {
  type = string
}
variable resource_group_name {
  type = string
}
variable communicator {
  type = string
}
variable os_type {
  type = string
}
variable image_offer {
  type = string
}
variable image_publisher {
  type = string
}
variable image_sku {
  type = string
}
variable vm_size {
  type = string
}
variable azure_tags {
  type = object({
    environment = string
    projectname = string
    owner       = string
  })
}
