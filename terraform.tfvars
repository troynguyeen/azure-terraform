# Authenticate
client_id       = "5f958331-de84-XXXX-9780-XXXXXXXXXX"
client_secret   = "3um8Q~-XXXXXXXXXXXXXXXXX-Bdvm"
tenant_id       = "e58c4816-XXXX-45ff-XXXX-XXXXXXXX5c5f"
subscription_id = "a5b2fb36-XXXX-4f3e-88ce-XXXXXXXX2474"

# Resource group
resource_group_name = "thanhnc85"
location            = "East Asia"

# Tags
azure_tags = {
  environment = "dev"
  projectname = "Terraform Project"
  owner       = "thanhnc85"
}

# Network
address_space         = "10.0.0.0/16"
address_prefixes      = "10.0.0.0/24"
allocation_method     = "Static"
sku                   = "Standard"
sku_tier              = "Regional"
http_port             = "80"
https_port            = "443"
ssh_port              = "22"
tcp_protocol          = "Tcp"
nsg_rule_direction    = "Inbound"
nsg_rule_allow_access = "Allow"
nsg_rule_deny_access  = "Deny"

# Virtual machine scale set
packer_image_name    = "nginx-ubuntu-thanhnc85-eastasia-dev-packerproject"
packer_image_version = "2.0.0"
image_publisher      = "Canonical"
image_offer          = "0001-com-ubuntu-server-jammy"
image_sku            = "22_04-lts"
image_version        = "latest"
instances            = 2
admin_username       = "thanhnc85"
public_key_path      = "~/.ssh/id_rsa.pub"
storage_account_type = "StandardSSD_LRS"
upgrade_mode         = "Automatic"
caching              = "ReadWrite"

# DNS
domain_name = "troynguyen.online"