resource "azurerm_managed_disk" "azure-disk" {
  name                 = "managed-disk-${local.naming_convention}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = 8
  tags = {
    environment = var.azure_tags.environment
    projectname = var.azure_tags.projectname
    owner       = var.azure_tags.owner
  }
}

# resource "azurerm_virtual_machine_data_disk_attachment" "azure-disk-vmss-attachment" {
#   managed_disk_id    = azurerm_managed_disk.azure-disk.id
#   virtual_machine_id = azurerm_linux_virtual_machine_scale_set.azure-vmss.id
#   lun                = 15
#   caching            = var.caching
# }