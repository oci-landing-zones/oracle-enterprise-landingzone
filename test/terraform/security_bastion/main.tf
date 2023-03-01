locals {
  test_compartment_name = "Test_sec_bast_home_compartment"
}

##### Test Compartments 

module "home_compartment" {
  source = "./compartment"

  compartment_parent_id     = var.tenancy_ocid
  compartment_name          = local.test_compartment_name
  compartment_description   = "Test Home comaprtment for Bastion tests"
  compartment_replication_delay = var.compartment_replication_delay

  providers = {
    oci = oci.home_region
  }
} 

module "environment_compartment" {
  source = "./compartment"

  compartment_parent_id     = module.home_compartment.compartment_id
  compartment_name          = "Test_sec_bast_env_compartment"
  compartment_description   = "Test environment comaprtment for Bastion tests"
  compartment_replication_delay = var.compartment_replication_delay

  providers = {
    oci = oci.home_region
  }
} 

module "shared_infra_compartment" {
  source = "./compartment"

  compartment_parent_id     = module.environment_compartment.compartment_id
  compartment_name          = "Test_sec_bast_si_compartment"
  compartment_description   = "Test Shared Infra comaprtment for Bastion tests"
  compartment_replication_delay = var.compartment_replication_delay

  providers = {
    oci = oci.home_region
  }
}

module "security_compartment" {
  source = "./compartment"

  compartment_parent_id     = module.shared_infra_compartment.compartment_id
  compartment_name          = "Test_sec_bast_sec_compartment"
  compartment_description   = "Test Security comaprtment for Bastion tests"
  compartment_replication_delay = var.compartment_replication_delay

  providers = {
    oci = oci.home_region
  }
}

module "network_compartment" {
  source = "./compartment"

  compartment_parent_id     = module.shared_infra_compartment.compartment_id
  compartment_name          = "Test_sec_bast_net_sec_compartment"
  compartment_description   = "Test Security comaprtment for Bastion tests"
  compartment_replication_delay = var.compartment_replication_delay

  providers = {
    oci = oci.home_region
  }
}

##### Test Network

resource "oci_core_vcn" "vcn_test_network" {
  cidr_blocks    = [var.vcn_cidr_block]
  compartment_id = module.network_compartment.compartment_id
  display_name   = "bastiontestnet"
  dns_label      = "basttestlabel"
  is_ipv6enabled = false
}

resource "oci_core_subnet" "test_subnet" {
  cidr_block                 = var.test_subnet_cidr_block
  display_name               = "Test_sec_bast_subnet"
  dns_label                  = "testbastsub"
  compartment_id             = module.network_compartment.compartment_id
  prohibit_public_ip_on_vnic = false
  vcn_id                     = oci_core_vcn.vcn_test_network.id
}

##### Create Security module to test 

module "security" {
  source                               = "../../../templates/elz-security"
  enable_cloud_guard                   = false
  resource_label                       = var.resource_label
  home_compartment_id                  = module.home_compartment.compartment_id
  cloud_guard_target_tenancy           = false
  tenancy_ocid                         = var.tenancy_ocid
  environment_prefix                   = var.environment_prefix
  home_compartment_name                = "Test Home"
  region                               = var.region
  environment_compartment_id           = module.environment_compartment.compartment_id
  security_compartment_id              = module.security_compartment.compartment_id
  enable_bastion                       = true
  bastion_target_subnet_id             = oci_core_subnet.test_subnet.id
  bastion_client_cidr_block_allow_list = ["0.0.0.0/0"]
  vault_type                           = "NONE"
  replica_region                       = ""
  enable_replication                   = false
  create_master_encryption_key         = false

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}
