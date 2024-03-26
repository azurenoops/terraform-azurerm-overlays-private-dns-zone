# Azure Private DNS Zone Overlay Terraform Module

[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![MIT License](https://img.shields.io/badge/license-MIT-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/azurenoops/overlays-private-dns-zone/azurerm/)

This Overlay Terraform Module creates an [Azure Private DNS Zone](https://learn.microsoft.com/en-us/azure/dns/private-dns-overview/) to be linked with an [Azure Virutal Network](https://learn.microsoft.com/en-us/azure/network) and manage related parameters to be used in a [SCCA compliant Network](https://registry.terraform.io/modules/azurenoops/overlays-management-hub/azurerm/latest).

## Using Azure Clouds

Since this module is built for both public and us government clouds. The `environment` variable defaults to `public` for Azure Cloud. When using this module with the Azure Government Cloud, you must set the `environment` variable to `usgovernment`. You will also need to set the azurerm provider `environment` variable to the proper cloud as well. This will ensure that the correct Azure Government Cloud endpoints are used. You will also need to set the `location` variable to a valid Azure Government Cloud location.

Example Usage for Azure Government Cloud:

```hcl

provider "azurerm" {
  environment = "usgovernment"
}

module "mod_ampls" {
  source  = "azurenoops/overlays-private-dns-zone/azurerm"
  version = "x.x.x"
  
  location = "usgovvirginia"
  environment = "usgovernment"
  ...
}

```

## SCCA Compliance

This module can be SCCA compliant and can be used in a SCCA compliant Network. Enable private endpoints and SCCA compliant network rules to make it SCCA compliant.

For more information, please read the [SCCA documentation](https://github.com/azurenoops/terraform-azurerm-overlays-compute-image-gallery/blob/main).

## Contributing

If you want to contribute to this repository, feel free to to contribute to our Terraform module.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## License

This Terraform module is open-sourced software licensed under the [MIT License](https://opensource.org/licenses/MIT).

## Resources Supported

| Name | Type |
|------|------|
| [azurerm_private_dns_zone.private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.private_dns_zone_vnet_links](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurenoopsutils_resource_name.private_dns_zone](https://registry.terraform.io/providers/azurenoops/azurenoopsutils/latest/docs/data-sources/resource_name) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Module Usage

```hcl
# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

module "mod_vng" {
  source  = "azurenoops/overlays-private-dns-zone/azurerm"
  version = "x.x.x"

  # Resource Group, location, VNet and Subnet details
  location           = var.location
  deploy_environment = var.deploy_environment
  environment        = var.environment
  org_name           = var.org_name
  workload_name      = var.workload_name

  private_dns_zone_name        = "privatelink.database.windows.net"
  existing_resource_group_name = module.dns-network-rg.resource_group_name
  private_dns_zone_vnets_ids = [
    azurerm_virtual_network.dns-vnet.id
  ]
  
  # Tags
  add_tags = {} # Tags to be applied to all resources
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_azurenoopsutils"></a> [azurenoopsutils](#requirement\_azurenoopsutils) | ~> 1.0.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.22 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurenoopsutils"></a> [azurenoopsutils](#provider\_azurenoopsutils) | ~> 1.0.4 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.22 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mod_azregions"></a> [mod\_azregions](#module\_mod\_azregions) | azurenoops/overlays-azregions-lookup/azurerm | ~> 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_zone.private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.private_dns_zone_vnet_links](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurenoopsutils_resource_name.private_dns_zone](https://registry.terraform.io/providers/azurenoops/azurenoopsutils/latest/docs/data-sources/resource_name) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_tags"></a> [add\_tags](#input\_add\_tags) | Map of custom tags. | `map(string)` | `{}` | no |
| <a name="input_custom_private_dns_zone_name"></a> [custom\_private\_dns\_zone\_name](#input\_custom\_private\_dns\_zone\_name) | The name of the custom dns zone name to create. If not set, the name will be generated using the `org_name`, `workload_name`, `deploy_environment` and `environment` variables. | `string` | `null` | no |
| <a name="input_default_tags_enabled"></a> [default\_tags\_enabled](#input\_default\_tags\_enabled) | Option to enable or disable default tags. | `bool` | `true` | no |
| <a name="input_deploy_environment"></a> [deploy\_environment](#input\_deploy\_environment) | Name of the workload's environnement | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The Terraform backend environment e.g. public or usgovernment | `string` | n/a | yes |
| <a name="input_existing_resource_group_name"></a> [existing\_resource\_group\_name](#input\_existing\_resource\_group\_name) | The name of the existing resource group to use to add the dns zone into. | `string` | `null` | no |
| <a name="input_is_not_private_link_service"></a> [is\_not\_private\_link\_service](#input\_is\_not\_private\_link\_service) | Boolean to determine if this module is used for Private Link Service or not. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region in which instance will be hosted | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Optional prefix for the generated name | `string` | `""` | no |
| <a name="input_name_suffix"></a> [name\_suffix](#input\_name\_suffix) | Optional suffix for the generated name | `string` | `""` | no |
| <a name="input_org_name"></a> [org\_name](#input\_org\_name) | Name of the organization | `string` | n/a | yes |
| <a name="input_private_dns_zone_name"></a> [private\_dns\_zone\_name](#input\_private\_dns\_zone\_name) | Private DNS Zone name. | `string` | n/a | yes |
| <a name="input_private_dns_zone_vnets_ids"></a> [private\_dns\_zone\_vnets\_ids](#input\_private\_dns\_zone\_vnets\_ids) | IDs of the VNets to link to the Private DNS Zone. | `list(string)` | n/a | yes |
| <a name="input_soa_record_private_dns"></a> [soa\_record\_private\_dns](#input\_soa\_record\_private\_dns) | Customize details about the root block device of the instance. See Block Devices below for details. | `list(object({}))` | `[]` | no |
| <a name="input_use_location_short_name"></a> [use\_location\_short\_name](#input\_use\_location\_short\_name) | Use short location name for resources naming (ie eastus -> eus). Default is true. If set to false, the full cli location name will be used. if custom naming is set, this variable will be ignored. | `bool` | `true` | no |
| <a name="input_use_naming"></a> [use\_naming](#input\_use\_naming) | Use the Azure NoOps naming provider to generate default resource name. `storage_account_custom_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |
| <a name="input_vm_autoregistration_enabled"></a> [vm\_autoregistration\_enabled](#input\_vm\_autoregistration\_enabled) | Is auto-registration of VM records in the VNet in the Private DNS zone enabled? Defaults to `false`. | `bool` | `false` | no |
| <a name="input_workload_name"></a> [workload\_name](#input\_workload\_name) | Name of the workload\_name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_dns_zone_id"></a> [private\_dns\_zone\_id](#output\_private\_dns\_zone\_id) | Private DNS Zone ID. |
| <a name="output_private_dns_zone_name"></a> [private\_dns\_zone\_name](#output\_private\_dns\_zone\_name) | Private DNS Zone name. |
| <a name="output_private_dns_zone_vnet_links_ids"></a> [private\_dns\_zone\_vnet\_links\_ids](#output\_private\_dns\_zone\_vnet\_links\_ids) | VNet links IDs. |
<!-- END_TF_DOCS -->