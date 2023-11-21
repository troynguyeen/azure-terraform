source azure-arm vm {
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id

  location                          = var.primary_location
  managed_image_name                = "${var.image_name}-${var.image_version}"
  managed_image_resource_group_name = var.resource_group_name

  communicator    = var.communicator
  os_type         = var.os_type
  image_offer     = var.image_offer
  image_publisher = var.image_publisher
  image_sku       = var.image_sku
  vm_size         = var.vm_size

  azure_tags = {
    environment = var.azure_tags.environment
    projectname = var.azure_tags.projectname
    owner       = var.azure_tags.owner
  }
}