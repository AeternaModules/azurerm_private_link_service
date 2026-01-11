resource "azurerm_private_link_service" "private_link_services" {
  for_each = var.private_link_services

  location                                    = each.value.location
  name                                        = each.value.name
  resource_group_name                         = each.value.resource_group_name
  auto_approval_subscription_ids              = each.value.auto_approval_subscription_ids
  destination_ip_address                      = each.value.destination_ip_address
  enable_proxy_protocol                       = each.value.enable_proxy_protocol
  fqdns                                       = each.value.fqdns
  load_balancer_frontend_ip_configuration_ids = each.value.load_balancer_frontend_ip_configuration_ids
  tags                                        = each.value.tags
  visibility_subscription_ids                 = each.value.visibility_subscription_ids

  dynamic "nat_ip_configuration" {
    for_each = each.value.nat_ip_configuration
    content {
      name                       = nat_ip_configuration.value.name
      primary                    = nat_ip_configuration.value.primary
      private_ip_address         = nat_ip_configuration.value.private_ip_address
      private_ip_address_version = nat_ip_configuration.value.private_ip_address_version
      subnet_id                  = nat_ip_configuration.value.subnet_id
    }
  }
}

