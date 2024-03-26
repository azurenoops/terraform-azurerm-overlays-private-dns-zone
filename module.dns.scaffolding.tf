# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

#--------------------------------------
# Azure Region Lookup
#--------------------------------------
# This module will lookup the Azure Region and return the short name for the region
module "mod_azure_region_lookup" {
  source  = "azurenoops/overlays-azregions-lookup/azurerm"
  version = "~> 1.0.0"

  azure_region = var.location
}

