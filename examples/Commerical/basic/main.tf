
module "mod_pdz" {
  source     = "../../.."
  depends_on = [module.dns-network-rg]

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

  add_tags = {}
}
