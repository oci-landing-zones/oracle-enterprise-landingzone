locals {
  test_compartment_name = "Test_sec_vault_home_${random_id.home_suffix.hex}"
}

resource "random_id" "home_suffix" {
  byte_length = 4
}

##### Test Compartments 

module "home_compartment" {
  source = "./compartment"

  compartment_parent_id     = var.tenancy_ocid
  compartment_name          = local.test_compartment_name
  compartment_description   = "Test Home comaprtment for vault tests"
  compartment_replication_delay = var.compartment_replication_delay

  providers = {
    oci = oci.home_region
  }
} 

module "environment_compartment" {
  source = "./compartment"

  compartment_parent_id     = module.home_compartment.compartment_id
  compartment_name          = "Test_sec_vault_env_compartment"
  compartment_description   = "Test environment comaprtment for vault tests"
  compartment_replication_delay = var.compartment_replication_delay

  providers = {
    oci = oci.home_region
  }
} 

module "shared_infra_compartment" {
  source = "./compartment"

  compartment_parent_id     = module.environment_compartment.compartment_id
  compartment_name          = "Test_sec_vault_si_compartment"
  compartment_description   = "Test Shared Infra comaprtment for Vault tests"
  compartment_replication_delay = var.compartment_replication_delay

  providers = {
    oci = oci.home_region
  }
}

module "security_compartment" {
  source = "./compartment"

  compartment_parent_id     = module.shared_infra_compartment.compartment_id
  compartment_name          = "Test_sec_vault_sec_compartment"
  compartment_description   = "Test Security comaprtment for Vault tests"
  compartment_replication_delay = var.compartment_replication_delay

  providers = {
    oci = oci.home_region
  }
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
  home_compartment_name                = local.test_compartment_name
  region                               = var.region
  environment_compartment_id           = module.environment_compartment.compartment_id
  security_compartment_id              = module.security_compartment.compartment_id
  enable_bastion                       = false
  bastion_target_subnet_id             = ""
  bastion_client_cidr_block_allow_list = ["0.0.0.0/0"]
  vault_type                           = "DEFAULT"
  replica_region                       = ""
  enable_replication                   = false
  create_master_encryption_key         = true

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}
