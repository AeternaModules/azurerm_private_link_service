variable "private_link_services" {
  description = <<EOT
Map of private_link_services, attributes below
Required:
    - location
    - name
    - resource_group_name
    - nat_ip_configuration (block):
        - name (required)
        - primary (required)
        - private_ip_address (optional)
        - private_ip_address_version (optional)
        - subnet_id (required)
Optional:
    - auto_approval_subscription_ids
    - destination_ip_address
    - enable_proxy_protocol
    - fqdns
    - load_balancer_frontend_ip_configuration_ids
    - tags
    - visibility_subscription_ids
EOT

  type = map(object({
    location                                    = string
    name                                        = string
    resource_group_name                         = string
    auto_approval_subscription_ids              = optional(set(string))
    destination_ip_address                      = optional(string)
    enable_proxy_protocol                       = optional(bool)
    fqdns                                       = optional(list(string))
    load_balancer_frontend_ip_configuration_ids = optional(set(string))
    tags                                        = optional(map(string))
    visibility_subscription_ids                 = optional(set(string))
    nat_ip_configuration = list(object({
      name                       = string
      primary                    = bool
      private_ip_address         = optional(string)
      private_ip_address_version = optional(string) # Default: "IPv4"
      subnet_id                  = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.private_link_services : (
        length(v.nat_ip_configuration) <= 8
      )
    ])
    error_message = "Each nat_ip_configuration list must contain at most 8 items"
  }
}

