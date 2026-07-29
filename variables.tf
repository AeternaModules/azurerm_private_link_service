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
    - fqdns
    - load_balancer_frontend_ip_configuration_ids
    - proxy_protocol_enabled
    - tags
    - visibility_subscription_ids
EOT

  type = map(object({
    location                                    = string
    name                                        = string
    resource_group_name                         = string
    auto_approval_subscription_ids              = optional(set(string))
    destination_ip_address                      = optional(string)
    fqdns                                       = optional(list(string))
    load_balancer_frontend_ip_configuration_ids = optional(set(string))
    proxy_protocol_enabled                      = optional(bool)
    tags                                        = optional(map(string))
    visibility_subscription_ids                 = optional(set(string))
    nat_ip_configuration = list(object({
      name                       = string
      primary                    = bool
      private_ip_address         = optional(string)
      private_ip_address_version = optional(string)
      subnet_id                  = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.private_link_services : (
        length(v.nat_ip_configuration) >= 1 && length(v.nat_ip_configuration) <= 8
      )
    ])
    error_message = "Each nat_ip_configuration list must contain between 1 and 8 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.private_link_services : (
        length(v.name) != 1
      )
    ])
    error_message = "[from networkValidate.PrivateLinkName: invalid when len(value) == 1]"
  }
  validation {
    condition = alltrue([
      for k, v in var.private_link_services : (
        length(v.resource_group_name) <= 90
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) > 90]"
  }
  validation {
    condition = alltrue([
      for k, v in var.private_link_services : (
        !endswith(v.resource_group_name, ".")
      )
    ])
    error_message = "[from resourcegroups.ValidateName: must not end with \".\"]"
  }
  validation {
    condition = alltrue([
      for k, v in var.private_link_services : (
        length(v.resource_group_name) != 0
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) == 0]"
  }
  validation {
    condition = alltrue([
      for k, v in var.private_link_services : (
        v.auto_approval_subscription_ids == null || (alltrue([for x in v.auto_approval_subscription_ids : can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", x))]))
      )
    ])
    error_message = "must be a valid UUID"
  }
  validation {
    condition = alltrue([
      for k, v in var.private_link_services : (
        v.visibility_subscription_ids == null || (alltrue([for x in v.visibility_subscription_ids : (can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", x))) || (contains(["*"], x))]))
      )
    ])
    error_message = "any of: must be a valid UUID; must be one of: *"
  }
  validation {
    condition = alltrue([
      for k, v in var.private_link_services : (
        v.fqdns == null || (alltrue([for x in v.fqdns : length(x) > 0]))
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.private_link_services : (
        alltrue([for item in v.nat_ip_configuration : (length(item.name) != 1)])
      )
    ])
    error_message = "[from networkValidate.PrivateLinkName: invalid when len(value) == 1]"
  }
  validation {
    condition = alltrue([
      for k, v in var.private_link_services : (
        v.tags == null || (length(v.tags) <= 50)
      )
    ])
    error_message = "[from tags.Validate: invalid when len(value) > 50]"
  }
  # Note: 19 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

