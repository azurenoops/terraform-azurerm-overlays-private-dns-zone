# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

################################
# Private DNS Configuration   ##
################################

variable "private_dns_zone_name" {
  description = "Private DNS Zone name."
  type        = string
}

variable "private_dns_zone_vnets_ids" {
  description = "IDs of the VNets to link to the Private DNS Zone."
  type        = list(string)
}

variable "is_not_private_link_service" {
  description = "Boolean to determine if this module is used for Private Link Service or not."
  type        = bool
  default     = true
}

variable "vm_autoregistration_enabled" {
  description = "Is auto-registration of VM records in the VNet in the Private DNS zone enabled? Defaults to `false`."
  type        = bool
  default     = false
}

variable "soa_record_private_dns" {
  type        = list(object({}))
  default     = []
  description = "Customize details about the root block device of the instance."
}
