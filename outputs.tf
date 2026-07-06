output "private_link_services" {
  description = "All private_link_service resources"
  value       = azurerm_private_link_service.private_link_services
}
output "private_link_services_alias" {
  description = "List of alias values across all private_link_services"
  value       = [for k, v in azurerm_private_link_service.private_link_services : v.alias]
}
output "private_link_services_auto_approval_subscription_ids" {
  description = "List of auto_approval_subscription_ids values across all private_link_services"
  value       = [for k, v in azurerm_private_link_service.private_link_services : v.auto_approval_subscription_ids]
}
output "private_link_services_destination_ip_address" {
  description = "List of destination_ip_address values across all private_link_services"
  value       = [for k, v in azurerm_private_link_service.private_link_services : v.destination_ip_address]
}
output "private_link_services_enable_proxy_protocol" {
  description = "List of enable_proxy_protocol values across all private_link_services"
  value       = [for k, v in azurerm_private_link_service.private_link_services : v.enable_proxy_protocol]
}
output "private_link_services_fqdns" {
  description = "List of fqdns values across all private_link_services"
  value       = [for k, v in azurerm_private_link_service.private_link_services : v.fqdns]
}
output "private_link_services_load_balancer_frontend_ip_configuration_ids" {
  description = "List of load_balancer_frontend_ip_configuration_ids values across all private_link_services"
  value       = [for k, v in azurerm_private_link_service.private_link_services : v.load_balancer_frontend_ip_configuration_ids]
}
output "private_link_services_location" {
  description = "List of location values across all private_link_services"
  value       = [for k, v in azurerm_private_link_service.private_link_services : v.location]
}
output "private_link_services_name" {
  description = "List of name values across all private_link_services"
  value       = [for k, v in azurerm_private_link_service.private_link_services : v.name]
}
output "private_link_services_nat_ip_configuration" {
  description = "List of nat_ip_configuration values across all private_link_services"
  value       = [for k, v in azurerm_private_link_service.private_link_services : v.nat_ip_configuration]
}
output "private_link_services_proxy_protocol_enabled" {
  description = "List of proxy_protocol_enabled values across all private_link_services"
  value       = [for k, v in azurerm_private_link_service.private_link_services : v.proxy_protocol_enabled]
}
output "private_link_services_resource_group_name" {
  description = "List of resource_group_name values across all private_link_services"
  value       = [for k, v in azurerm_private_link_service.private_link_services : v.resource_group_name]
}
output "private_link_services_tags" {
  description = "List of tags values across all private_link_services"
  value       = [for k, v in azurerm_private_link_service.private_link_services : v.tags]
}
output "private_link_services_visibility_subscription_ids" {
  description = "List of visibility_subscription_ids values across all private_link_services"
  value       = [for k, v in azurerm_private_link_service.private_link_services : v.visibility_subscription_ids]
}

