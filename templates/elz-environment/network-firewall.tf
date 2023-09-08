module "network-firewall" {
  source                            = "../elz-network-firewall"
  tenancy_ocid                      = var.tenancy_ocid
  region                            = var.region
  environment_prefix                = var.environment_prefix

  network_compartment_id            = module.compartment.compartments.network.id
  home_compartment_id               = var.home_compartment_id
  is_baseline_deploy                = var.is_baseline_deploy

  enable_network_firewall           = var.enable_network_firewall
  enable_traffic_threat_log         = var.enable_traffic_threat_log
  nfw_subnet_type                   = var.nfw_subnet_type
  nfw_instance_name                 = var.nfw_instance_name
  nfw_instance_policy               = var.nfw_instance_policy
  nfw_subnet_cidr_block             = var.nfw_subnet_cidr_block

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}
