locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  private_dns_zone_name = coalesce(var.custom_private_dns_zone_name, data.azurenoopsutils_resource_name.private_dns_zone.result)
}
