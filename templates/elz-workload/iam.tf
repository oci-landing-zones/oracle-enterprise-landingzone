# -----------------------------------------------------------------------------
# Compartment Resources 
# -----------------------------------------------------------------------------
locals {
  workload_compartment = {
    name        = var.workload_compartment_name != "" ? var.workload_compartment_name : "OCI-ELZ-${var.environment_prefix}-${var.workload_name}-${local.region_key[0]}"
    description = "Workload Compartment"
  }

  group_names = {
    workload_admin_group_name : var.workload_admin_group_name != "" ? var.workload_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-WRK-ADMIN",
    application_admin_group_name : var.application_admin_group_name != "" ? var.application_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-APP-ADMIN",
    database_admin_group_name : var.database_admin_group_name != "" ? var.database_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-DB-ADMIN",
  }

  base_group_names = {
    network_admin_group_name : var.network_admin_group_name != "" ? var.network_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-NET-ADMIN",
  }

  workload_expansion_policy = {
    name        = "OCI-ELZ-WRK-EXP-${var.workload_prefix}-POLICY"
    description = "OCI Workload Expansion Policy"
    statements = [
      "Allow group ${var.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to manage virtual-network-family in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to manage alarms in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to manage ons-topics in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to manage ons-subscriptions in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to manage logging-family in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to manage streams in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to read announcements in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to read metrics in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to read audit-events in compartment ${module.workload_compartment.compartment_name}",

      "Allow group ${var.identity_domain_name}/${local.group_names["application_admin_group_name"]} to manage load-balancers in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.group_names["application_admin_group_name"]} to manage volume-family in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.group_names["application_admin_group_name"]} to manage object-family in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.group_names["application_admin_group_name"]} to manage file-family in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.group_names["application_admin_group_name"]} to manage instance-family in compartment ${module.workload_compartment.compartment_name}",

      "Allow group ${var.identity_domain_name}/${local.group_names["database_admin_group_name"]} to read autonomous-database-family in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.group_names["database_admin_group_name"]} to read database-family in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.base_group_names["network_admin_group_name"]} to read metrics in compartment ${module.workload_compartment.compartment_name}",
    ]
  }

  workload_expansion_policy_security = {
    name        = "OCI-ELZ-WRK-EXP-${var.workload_prefix}-SEC-POLICY"
    description = "OCI Workload Expansion Security Policy"

    statements = [
      "Allow group ${var.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to read vaults in compartment ${var.security_compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to inspect keys in compartment ${var.security_compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to read vss-family in compartment ${var.security_compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to use bastion in compartment ${var.security_compartment_name}",
      "Allow group ${var.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to manage bastion-session in compartment ${var.security_compartment_name}",
    ]
  }
}

module "workload_compartment" {
  source = "../../modules/compartment"

  compartment_parent_id     = var.environment_compartment_id
  compartment_name          = local.workload_compartment.name
  compartment_description   = local.workload_compartment.description
  enable_compartment_delete = var.enable_compartment_delete

  providers = {
    oci = oci.home_region
  }
}

module "groups" {
  source             = "../../modules/identity-domain-group"
  identity_domain_id = var.identity_domain_id
  group_names        = values(local.group_names)
}

module "workload_expansion_policy" {
  source           = "../../modules/policies"
  compartment_ocid = module.workload_compartment.compartment_id
  policy_name      = local.workload_expansion_policy.name
  description      = local.workload_expansion_policy.description
  statements       = local.workload_expansion_policy.statements
}

module "workload_expansion_sec_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.security_compartment_id
  policy_name      = local.workload_expansion_policy_security.name
  description      = local.workload_expansion_policy_security.description
  statements       = local.workload_expansion_policy_security.statements
}
