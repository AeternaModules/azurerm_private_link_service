output "private_link_services_id" {
  description = "Map of id values across all private_link_services, keyed the same as var.private_link_services"
  value       = { for k, v in azurerm_private_link_service.private_link_services : k => v.id if v.id != null && length(v.id) > 0 }
}
output "private_link_services_alias" {
  description = "Map of alias values across all private_link_services, keyed the same as var.private_link_services"
  value       = { for k, v in azurerm_private_link_service.private_link_services : k => v.alias if v.alias != null && length(v.alias) > 0 }
}
output "private_link_services_auto_approval_subscription_ids" {
  description = "Map of auto_approval_subscription_ids values across all private_link_services, keyed the same as var.private_link_services"
  value       = { for k, v in azurerm_private_link_service.private_link_services : k => v.auto_approval_subscription_ids if v.auto_approval_subscription_ids != null && length(v.auto_approval_subscription_ids) > 0 }
}
output "private_link_services_destination_ip_address" {
  description = "Map of destination_ip_address values across all private_link_services, keyed the same as var.private_link_services"
  value       = { for k, v in azurerm_private_link_service.private_link_services : k => v.destination_ip_address if v.destination_ip_address != null && length(v.destination_ip_address) > 0 }
}
output "private_link_services_enable_proxy_protocol" {
  description = "Map of enable_proxy_protocol values across all private_link_services, keyed the same as var.private_link_services"
  value       = { for k, v in azurerm_private_link_service.private_link_services : k => v.enable_proxy_protocol if v.enable_proxy_protocol != null }
}
output "private_link_services_fqdns" {
  description = "Map of fqdns values across all private_link_services, keyed the same as var.private_link_services"
  value       = { for k, v in azurerm_private_link_service.private_link_services : k => v.fqdns if v.fqdns != null && length(v.fqdns) > 0 }
}
output "private_link_services_load_balancer_frontend_ip_configuration_ids" {
  description = "Map of load_balancer_frontend_ip_configuration_ids values across all private_link_services, keyed the same as var.private_link_services"
  value       = { for k, v in azurerm_private_link_service.private_link_services : k => v.load_balancer_frontend_ip_configuration_ids if v.load_balancer_frontend_ip_configuration_ids != null && length(v.load_balancer_frontend_ip_configuration_ids) > 0 }
}
output "private_link_services_location" {
  description = "Map of location values across all private_link_services, keyed the same as var.private_link_services"
  value       = { for k, v in azurerm_private_link_service.private_link_services : k => v.location if v.location != null && length(v.location) > 0 }
}
output "private_link_services_name" {
  description = "Map of name values across all private_link_services, keyed the same as var.private_link_services"
  value       = { for k, v in azurerm_private_link_service.private_link_services : k => v.name if v.name != null && length(v.name) > 0 }
}
output "private_link_services_nat_ip_configuration" {
  description = "Map of nat_ip_configuration values across all private_link_services, keyed the same as var.private_link_services"
  value       = { for k, v in azurerm_private_link_service.private_link_services : k => v.nat_ip_configuration if v.nat_ip_configuration != null && length(v.nat_ip_configuration) > 0 }
}
output "private_link_services_proxy_protocol_enabled" {
  description = "Map of proxy_protocol_enabled values across all private_link_services, keyed the same as var.private_link_services"
  value       = { for k, v in azurerm_private_link_service.private_link_services : k => v.proxy_protocol_enabled if v.proxy_protocol_enabled != null }
}
output "private_link_services_resource_group_name" {
  description = "Map of resource_group_name values across all private_link_services, keyed the same as var.private_link_services"
  value       = { for k, v in azurerm_private_link_service.private_link_services : k => v.resource_group_name if v.resource_group_name != null && length(v.resource_group_name) > 0 }
}
output "private_link_services_tags" {
  description = "Map of tags values across all private_link_services, keyed the same as var.private_link_services"
  value       = { for k, v in azurerm_private_link_service.private_link_services : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "private_link_services_visibility_subscription_ids" {
  description = "Map of visibility_subscription_ids values across all private_link_services, keyed the same as var.private_link_services"
  value       = { for k, v in azurerm_private_link_service.private_link_services : k => v.visibility_subscription_ids if v.visibility_subscription_ids != null && length(v.visibility_subscription_ids) > 0 }
}

