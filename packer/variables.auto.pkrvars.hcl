primary_location    = "East Asia"
image_name          = "nginx-ubuntu-thanhnc85-eastasia-dev-packerproject"
image_version       = "2.0.0"
resource_group_name = "thanhnc85"
communicator        = "ssh"
os_type             = "Linux"
image_offer         = "0001-com-ubuntu-server-jammy"
image_publisher     = "canonical"
image_sku           = "22_04-lts"
vm_size             = "Standard_B1s"
azure_tags = {
  environment = "dev"
  projectname = "Packer Project"
  owner       = "thanhnc85"
}