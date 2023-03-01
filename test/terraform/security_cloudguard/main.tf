locals {
  test_compartment_name = "Test_sec_cg_home_compartment"

  cloud_guard_policy = {
    name        = "${var.resource_label}-OCI-ELZ-CG-Policy"
    description = "OCI Enterprise Landing Zone Cloud Guard Policy"

    statements = [
      "Allow service cloudguard to read vaults in tenancy",
      "Allow service cloudguard to read keys in tenancy",
      "Allow service cloudguard to read compartments in tenancy",
      "Allow service cloudguard to read tenancies in tenancy",
      "Allow service cloudguard to read audit-events in tenancy",
      "Allow service cloudguard to read compute-management-family in tenancy",
      "Allow service cloudguard to read instance-family in tenancy",
      "Allow service cloudguard to read virtual-network-family in tenancy",
      "Allow service cloudguard to read volume-family in tenancy",
      "Allow service cloudguard to read database-family in tenancy",
      "Allow service cloudguard to read object-family in tenancy",
      "Allow service cloudguard to read load-balancers in tenancy",
      "Allow service cloudguard to read users in tenancy",
      "Allow service cloudguard to read groups in tenancy",
      "Allow service cloudguard to read policies in tenancy",
      "Allow service cloudguard to read dynamic-groups in tenancy",
      "Allow service cloudguard to read authentication-policies in tenancy",
      "Allow service cloudguard to use network-security-groups in tenancy",
      "Allow service cloudguard to read data-safe-family in tenancy",
      "Allow service cloudguard to read autonomous-database-family in tenancy",
      "Allow service cloudguard to manage cloudevents-rules in tenancy where target.rule.type='managed'"
    ]
  }

  cloud_guard_target_policy = {
    name        = "${var.resource_label}-OCI-ELZ-CGTarget-Policy"
    description = "OCI Enterprise Landing Zone Cloud Guard Target Policy"

    statements = [
      "Allow service cloudguard to manage instance-family in compartment ${local.test_compartment_name}",
      "Allow service cloudguard to manage object-family in compartment ${local.test_compartment_name}",
      "Allow service cloudguard to manage buckets in compartment ${local.test_compartment_name}",
      "Allow service cloudguard to manage users in compartment ${local.test_compartment_name}",
      "Allow service cloudguard to manage policies in compartment ${local.test_compartment_name}",
      "Allow service cloudguard to manage keys in compartment ${local.test_compartment_name}"
    ]
  }
}

##### Test Compartments 

module "home_compartment" {
  source = "./compartment"

  compartment_parent_id     = var.tenancy_ocid
  compartment_name          = local.test_compartment_name
  compartment_description   = "Test Home comaprtment for CG tests"
  compartment_replication_delay = var.compartment_replication_delay

  providers = {
    oci = oci.home_region
  }
} 

module "environment_compartment" {
  source = "./compartment"

  compartment_parent_id     = module.home_compartment.compartment_id
  compartment_name          = "Test_sec_cg_env_compartment"
  compartment_description   = "Test environment comaprtment for CG tests"
  compartment_replication_delay = var.compartment_replication_delay

  providers = {
    oci = oci.home_region
  }
} 

module "shared_infra_compartment" {
  source = "./compartment"

  compartment_parent_id     = module.environment_compartment.compartment_id
  compartment_name          = "Test_sec_cg_si_compartment"
  compartment_description   = "Test Shared Infra comaprtment for CG tests"
  compartment_replication_delay = var.compartment_replication_delay

  providers = {
    oci = oci.home_region
  }
}

module "security_compartment" {
  source = "./compartment"

  compartment_parent_id     = module.shared_infra_compartment.compartment_id
  compartment_name          = "Test_sec_cg_sec_compartment"
  compartment_description   = "Test Security comaprtment for CG tests"
  compartment_replication_delay = var.compartment_replication_delay

  providers = {
    oci = oci.home_region
  }
}

##### Policies

###############################################################################
## Note: I don't like that we have to create these policies here to test. 
##       It would be better to test the policy creation along with the
##       cloudguard resource creation, But the security module is not 
##       self-contained, these policies are created in the top-level
##       "enterprise-landing-zone" template, and thus can't be instantiated 
##       separately. 
###############################################################################

module "cloud_guard_root_policy" {
  source           = "./policies"
  compartment_ocid = var.tenancy_ocid
  policy_name      = local.cloud_guard_policy.name
  description      = local.cloud_guard_policy.description
  statements       = local.cloud_guard_policy.statements
}

module "cloud_guard_target_policy" {
  source           = "./policies"
  compartment_ocid = module.home_compartment.compartment_id
  policy_name      = local.cloud_guard_target_policy.name
  description      = local.cloud_guard_target_policy.description
  statements       = local.cloud_guard_target_policy.statements

  depends_on = [module.home_compartment]
}

##### Create Security module to test 

module "security" {
  source                               = "../../../templates/elz-security"
  enable_cloud_guard                   = true
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
  vault_type                           = "NONE"
  replica_region                       = ""
  enable_replication                   = false
  create_master_encryption_key         = false

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}
