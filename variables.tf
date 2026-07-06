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
    enable_proxy_protocol                       = optional(bool)
    fqdns                                       = optional(list(string))
    load_balancer_frontend_ip_configuration_ids = optional(set(string))
    proxy_protocol_enabled                      = optional(bool)
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
  validation {
    condition = alltrue([
      for k, v in var.private_link_services : (
        v.auto_approval_subscription_ids == null || (can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", v.auto_approval_subscription_ids)))
      )
    ])
    error_message = "must be a valid UUID"
  }
  validation {
    condition = alltrue([
      for k, v in var.private_link_services : (
        v.fqdns == null || (length(v.fqdns) > 0)
      )
    ])
    error_message = "must not be empty"
  }
  # --- Unconfirmed validation candidates, derived from azurerm_private_link_service's provider source ---
  # Not auto-enabled: either a bespoke provider validator we can't safely translate,
  # or a path that crosses a list-typed block (needs its own for_each wrapping).
  # Review, translate into a real validation{} block above, and delete once confirmed.
  # path: name
  #   source:    [from networkValidate.PrivateLinkName] !ok
  # path: name
  #   condition: length(value) != 1
  #   message:   [from networkValidate.PrivateLinkName: invalid when len(value) == 1]
  #   source:    [from networkValidate.PrivateLinkName: invalid when len(value) == 1]
  # path: name
  #   source:    [from networkValidate.PrivateLinkName] !m
  # path: name
  #   source:    [from networkValidate.PrivateLinkName] !m
  # path: location
  #   source:    location.EnhancedValidate: no recognizable `if ... { errors = append(...) }` pattern - read it by hand
  # path: resource_group_name
  #   condition: length(value) <= 90
  #   message:   [from resourcegroups.ValidateName: invalid when len(value) > 90]
  #   source:    [from resourcegroups.ValidateName: invalid when len(value) > 90]
  # path: resource_group_name
  #   condition: !endswith(value, ".")
  #   message:   [from resourcegroups.ValidateName: must not end with "."]
  #   source:    [from resourcegroups.ValidateName: must not end with "."]
  # path: resource_group_name
  #   condition: length(value) != 0
  #   message:   [from resourcegroups.ValidateName: invalid when len(value) == 0]
  #   source:    [from resourcegroups.ValidateName: invalid when len(value) == 0]
  # path: resource_group_name
  #   source:    [from resourcegroups.ValidateName] !matched
  # path: destination_ip_address
  #   source:    validation.IsIPv4Address(...) - no translation rule yet, add one
  # path: visibility_subscription_ids[*]
  #   source:    validation.Any(...) - no translation rule yet, add one
  # path: nat_ip_configuration.name
  #   source:    [from networkValidate.PrivateLinkName] !ok
  # path: nat_ip_configuration.name
  #   condition: length(value) != 1
  #   message:   [from networkValidate.PrivateLinkName: invalid when len(value) == 1]
  #   source:    [from networkValidate.PrivateLinkName: invalid when len(value) == 1]
  # path: nat_ip_configuration.name
  #   source:    [from networkValidate.PrivateLinkName] !m
  # path: nat_ip_configuration.name
  #   source:    [from networkValidate.PrivateLinkName] !m
  # path: nat_ip_configuration.private_ip_address
  #   source:    [from validate.IPv4Address] !ok
  # path: nat_ip_configuration.private_ip_address
  #   source:    [from validate.IPv4Address] four == nil
  # path: nat_ip_configuration.private_ip_address_version
  #   source:    validation.StringInSlice value list is not a literal []string - likely a generated PossibleValuesFor*() helper; resolve separately
  # path: nat_ip_configuration.subnet_id
  #   source:    [from commonids.ValidateSubnetID] !ok
  # path: nat_ip_configuration.subnet_id
  #   source:    [from commonids.ValidateSubnetID] err != nil
  # path: load_balancer_frontend_ip_configuration_ids[*]
  #   source:    [from azure.ValidateResourceID] !ok
  # path: load_balancer_frontend_ip_configuration_ids[*]
  #   source:    [from azure.ValidateResourceID] err != nil
  # path: tags
  #   condition: length(value) <= 50
  #   message:   [from tags.Validate: invalid when len(value) > 50]
  #   source:    [from tags.Validate: invalid when len(value) > 50]
  # path: tags
  #   condition: length(value) <= 512
  #   message:   [from tags.Validate: invalid when len(value) > 512]
  #   source:    [from tags.Validate: invalid when len(value) > 512]
  # path: tags
  #   source:    [from tags.Validate] err != nil
  # path: tags
  #   condition: length(value) <= 256
  #   message:   [from tags.Validate: invalid when len(value) > 256]
  #   source:    [from tags.Validate: invalid when len(value) > 256]
}

