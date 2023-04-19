locals {
  availability_domains = data.oci_identity_availability_domains.ad.availability_domains
  test_compartment_ocid = var.compartment_ocid != "" ? var.compartment_ocid : var.tenancy_ocid
  network_compartment_name = "Test_net_compartment"
  workload_compartment_name = "Test_wrk_compartment"
}

# ---------------------------------------------------------------------------------------------------------------------
# Create compartments
# ---------------------------------------------------------------------------------------------------------------------

module "environment_compartment" {
  source = "./compartment"

  compartment_parent_id     = local.test_compartment_ocid
  compartment_name          = "Test_net_env_compartment"
  compartment_description   = "Test environment comaprtment for network tests"
  compartment_replication_delay = var.compartment_replication_delay

  providers = {
    oci = oci.home_region
  }
} 

module "network_compartment" {
  source = "./compartment"

  compartment_parent_id     = module.environment_compartment.compartment_id
  compartment_name          = local.network_compartment_name
  compartment_description   = "Test Network comaprtment for Net tests"
  compartment_replication_delay = var.compartment_replication_delay

  providers = {
    oci = oci.home_region
  }
}

module "workload_compartment" {
  source = "./compartment"

  compartment_parent_id     = module.environment_compartment.compartment_id
  compartment_name          = local.workload_compartment_name
  compartment_description   = "Test Workload comaprtment for Net tests"
  compartment_replication_delay = var.compartment_replication_delay

  providers = {
    oci = oci.home_region
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# Call network module to set up hub and spoke network here:
# ---------------------------------------------------------------------------------------------------------------------
#
module "network" {
  source             = "../../../templates/elz-network"

  tenancy_ocid = var.tenancy_ocid
  region = var.region
  environment_prefix = var.environment_prefix

  enable_internet_gateway_hub = "true"
  enable_nat_gateway_hub = "true"
  enable_service_gateway_hub = "true"

  network_compartment_id = module.network_compartment.compartment_id

  vcn_cidr_block = var.vcn_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block

  private_spoke_subnet_web_cidr_block = var.private_spoke_subnet_web_cidr_block
  private_spoke_subnet_app_cidr_block = var.private_spoke_subnet_app_cidr_block
  private_spoke_subnet_db_cidr_block = var.private_spoke_subnet_db_cidr_block
  spoke_vcn_cidr = var.spoke_vcn_cidr

  add_ssh_to_security_list = true

  customer_onprem_ip_cidr = []
  ipsec_connection_static_routes = [""]
  enable_vpn_or_fastconnect = "NONE"
  enable_vpn_on_environment = false
  enable_fastconnect_on_environment = false
  
  nat_gw_hub_check = [""]
  service_gw_hub_check = [""]
  nat_gw_spoke_check = [""]
  igw_hub_check = [""]
  service_gw_spoke_check = [""]

  workload_compartment_id = module.workload_compartment.compartment_id
  additional_workload_subnets_cidr_blocks = var.additional_workload_subnets_cidr_blocks
  workload_compartment_name = local.workload_compartment_name

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}

#
# ========
# Fetch public hub subnet and 3 private workload subnets
# from network module. Module will need to utput those values.
# ========
locals {  
  pub_subnet = module.network.subnets["OCI-ELZ-SUB-${var.environment_prefix}-HUB-${local.region_key[0]}001"]
  priv_subnets = [
    module.network.subnets["OCI-ELZ-SUB-${var.environment_prefix}-SPK-${local.region_key[0]}001"],
    module.network.subnets["OCI-ELZ-SUB-${var.environment_prefix}-SPK-${local.region_key[0]}002"],
    module.network.subnets["OCI-ELZ-SUB-${var.environment_prefix}-SPK-${local.region_key[0]}003"],
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# Create Bastion
# ---------------------------------------------------------------------------------------------------------------------
module "bastion" {
  source               = "./test_instance"
  compartment_ocid     = module.workload_compartment.compartment_id
  hostname             = "hub-bastion"
  ssh_public_keys      = join("\n", var.ssh_public_key_list)
  subnet_id            = local.pub_subnet
  needs_public_ip      = true
  instance_shape       = var.test_instance_shape
  image_id             = data.oci_core_images.ol_images.images.0.id
  availability_domain  = lookup(local.availability_domains[0], "name")
}

# ---------------------------------------------------------------------------------------------------------------------
# Create private test instances
# ---------------------------------------------------------------------------------------------------------------------
module "test_nodes" {
  source               = "./test_instance"
  count                = length(local.priv_subnets)
  compartment_ocid     = module.workload_compartment.compartment_id

  hostname             = "spoke-${count.index + 1}-test"
  ssh_public_keys      = join("\n", var.ssh_public_key_list)
  subnet_id            = local.priv_subnets[count.index]
  needs_public_ip      = false

  instance_shape       = var.test_instance_shape
  image_id             = data.oci_core_images.ol_images.images.0.id
  availability_domain  = lookup(local.availability_domains[0], "name")
}

resource "time_sleep" "sshd_start_delay" {
  depends_on = [module.bastion, module.test_nodes]
  create_duration = "60s"
}