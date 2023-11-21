# Authenticate
client_id       = "5f958331-de84-4f04-9780-4664d1bb2a4d"
client_secret   = "3um8Q~-SOx4e3BpMGA8gF8JKt4SSz9u9Tyy-Bdvm"
tenant_id       = "e58c4816-2a3b-45ff-ba8e-11ad7b5e5c5f"
subscription_id = "a5b2fb36-2de8-4f3e-88ce-81d365b92474"

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