# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#---------------------------------------------------------------
# Azure Private DNS Zone
#----------------------------------------------------------------
resource "azurerm_private_dns_zone" "private_dns_zone" {
  name = var.private_dns_zone_name

  resource_group_name = var.existing_resource_group_name
  tags = local.default_tags

  dynamic "soa_record" {
    for_each = var.soa_record_private_dns
    content {
      email        = lookup(soa_record.value, "email", null)
      expire_time  = lookup(soa_record.value, "expire_time", null)
      minimum_ttl  = lookup(soa_record.value, "minimum_ttl", null)
      refresh_time = lookup(soa_record.value, "refresh_time", null)
      retry_time   = lookup(soa_record.value, "retry_time", null)
      ttl          = lookup(soa_record.value, "ttl", null)
    }
  }

  lifecycle {
    precondition {
      condition     = var.is_not_private_link_service
      error_message = "Private Link Service does not require the deployment of Private DNS Zones."
    }
  }
}
