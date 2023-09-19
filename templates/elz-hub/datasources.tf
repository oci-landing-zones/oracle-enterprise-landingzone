######################################################################
#                Support for multi-region deployments                #
######################################################################
locals {
  region_subscriptions = data.oci_identity_region_subscriptions.regions.region_subscriptions
  home_region          = [for region in local.region_subscriptions : region.region_name if region.is_home_region == true]
  region_key           = [for region in local.region_subscriptions : region.region_key if region.region_name == var.region]
}
######################################################################
#                    Get Tenancy OCID From the Region                #
######################################################################
data "oci_identity_region_subscriptions" "regions" {
  tenancy_id = var.tenancy_ocid
}

######################################################################
#              Get the Private IPs using Trust Subnet                #
######################################################################
data "oci_core_private_ips" "firewall_subnet_private_ip" {
  subnet_id = local.nfw_subnet_id
  filter {
    name   = "display_name"
    values = [local.network_firewall_info.network_firewall_name]
  }
}

#data "oci_core_private_ips" "firewall_subnet_public_ip" {
#  subnet_id = local.public_subnet_id
#  filter {
#    name   = "display_name"
#    values = [local.network_firewall_info.network_firewall_name]
#    depends_on = [
#      oci_network_firewall_network_firewall.network_firewall
#    ]
#  }
#}