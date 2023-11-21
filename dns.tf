resource "azurerm_dns_a_record" "azure-dns-record" {
  name                = "www"
  zone_name           = var.domain_name
  resource_group_name = var.resource_group_name
  ttl                 = 1
  target_resource_id  = azurerm_public_ip.azure-public-ip.id
}