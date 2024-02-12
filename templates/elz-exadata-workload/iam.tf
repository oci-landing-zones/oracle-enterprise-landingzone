##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

# -----------------------------------------------------------------------------
# Compartment Resources 
# -----------------------------------------------------------------------------
locals {
  workload_compartment = {
    name        = var.workload_compartment_name != "" ? var.workload_compartment_name : "OCI-ELZ-${var.environment_prefix}-${var.workload_name}-${local.region_key[0]}"
    description = "Exadata Workload Compartment"
  }

  group_names = var.enable_datasafe ? {
    workload_admin_group_name : var.workload_admin_group_name != "" ? var.workload_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-${var.workload_name}-WRK-ADMIN",
    application_admin_group_name : var.application_admin_group_name != "" ? var.application_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-${var.workload_name}-APP-ADMIN",
    exadata_infra_admin_group_name : var.exadata_infra_admin_group_name != "" ? var.exadata_infra_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-${var.workload_name}-EXA-INFRA-ADMIN",
    database_admin_group_name : var.database_admin_group_name != "" ? var.database_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-${var.workload_name}-DB-ADMIN",
    datasafe_admin_group_name : var.datasafe_admin_group_name != "" ? var.datasafe_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-${var.workload_name}-DTSAFE-ADMIN",
    datasafe_reports_group_name : var.datasafe_reports_group_name != "" ? var.datasafe_reports_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-${var.workload_name}-DTSAFE-REPORTS",
    } : {
    workload_admin_group_name : var.workload_admin_group_name != "" ? var.workload_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-${var.workload_name}-WRK-ADMIN",
    application_admin_group_name : var.application_admin_group_name != "" ? var.application_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-${var.workload_name}-APP-ADMIN",
    exadata_infra_admin_group_name : var.exadata_infra_admin_group_name != "" ? var.exadata_infra_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-${var.workload_name}-EXA-INFRA-ADMIN",
    database_admin_group_name : var.database_admin_group_name != "" ? var.database_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-${var.workload_name}-DB-ADMIN",
  }

  base_group_names = {
    network_admin_group_name : var.network_admin_group_name != "" ? var.network_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-NET-ADMIN",
    # security_admin_group_name : var.security_admin_group_name != "" ? var.security_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-SEC-ADMIN",
  }

  identity_domain_name = var.identity_domain_name != "" ? var.identity_domain_name : "OCI-ELZ-${var.environment_prefix}-IDT"

  parent_compartment_names = {
    security_compartment_name : var.security_compartment_name != "" ? var.security_compartment_name : "OCI-ELZ-${var.environment_prefix}-SRD-SEC"
    environment_compartment_name : var.environment_compartment_name != "" ? var.environment_compartment_name : "OCI-ELZ-${var.environment_prefix}-CMP"
  }

  exadata_workload_expansion_policy = {
    name        = "OCI-ELZ-EXAWRK-EXP-${var.workload_prefix}-POLICY"
    description = "OCI Exadata Workload Expansion Policy"
    statements = concat([
      "Allow group ${local.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to manage virtual-network-family in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to manage alarms in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to manage ons-topics in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to manage ons-subscriptions in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to manage logging-family in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to manage streams in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to read announcements in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to read metrics in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to read audit-events in compartment ${module.workload_compartment.compartment_name}",

      "Allow group ${local.identity_domain_name}/${local.group_names["application_admin_group_name"]} to manage load-balancers in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["application_admin_group_name"]} to manage volume-family in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["application_admin_group_name"]} to manage object-family in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["application_admin_group_name"]} to manage file-family in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["application_admin_group_name"]} to manage instance-family in compartment ${module.workload_compartment.compartment_name}",

      "Allow group ${local.identity_domain_name}/${local.group_names["exadata_infra_admin_group_name"]} to manage cloud-exadata-infrastructures in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["exadata_infra_admin_group_name"]} to manage cloud-vmclusters in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["exadata_infra_admin_group_name"]} to read work-requests in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["exadata_infra_admin_group_name"]} to manage bastion-session in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["exadata_infra_admin_group_name"]} to manage instance-family in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["exadata_infra_admin_group_name"]} to read instance-agent-plugins in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["exadata_infra_admin_group_name"]} to manage ons-family in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["exadata_infra_admin_group_name"]} to manage alarms in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["exadata_infra_admin_group_name"]} to manage metrics in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["exadata_infra_admin_group_name"]} to manage data-safe-family in compartment ${module.workload_compartment.compartment_name}",

      "Allow group ${local.identity_domain_name}/${local.group_names["database_admin_group_name"]} to read cloud-exadata-infrastructures in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["database_admin_group_name"]} to use cloud-vmclusters in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["database_admin_group_name"]} to read work-requests in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["database_admin_group_name"]} to manage db-nodes in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["database_admin_group_name"]} to manage db-homes in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["database_admin_group_name"]} to manage databases in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["database_admin_group_name"]} to manage db-backups in compartment ${module.workload_compartment.compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["database_admin_group_name"]} to manage data-safe-family in compartment ${module.workload_compartment.compartment_name}",

      "Allow group ${local.identity_domain_name}/${local.base_group_names["network_admin_group_name"]} to read metrics in compartment ${module.workload_compartment.compartment_name}",
      ], flatten(
      var.enable_datasafe ? [
        "Allow group ${local.identity_domain_name}/${local.group_names["database_admin_group_name"]} to manage target-databases in compartment ${module.workload_compartment.compartment_name}",
        "Allow group ${local.identity_domain_name}/${local.group_names["database_admin_group_name"]} to manage database-family in compartment ${module.workload_compartment.compartment_name}",
        "Allow group ${local.identity_domain_name}/${local.group_names["database_admin_group_name"]} to manage autonomous-databases in compartment ${module.workload_compartment.compartment_name}",
        "Allow group ${local.identity_domain_name}/${local.group_names["database_admin_group_name"]} to manage autonomous-container-databases in compartment ${module.workload_compartment.compartment_name}",
        "Allow group ${local.identity_domain_name}/${local.group_names["exadata_infra_admin_group_name"]} to inspect autonomous-vmclusters in compartment ${module.workload_compartment.compartment_name}",
        # "Allow group ${local.identity_domain_name}/${local.group_names["exadata_infra_admin_group_name"]} to inspect vmcluster-network in compartment ${module.workload_compartment.compartment_name}",
        "Allow group ${local.identity_domain_name}/${local.group_names["exadata_infra_admin_group_name"]} to manage virtual-network-family in compartment ${module.workload_compartment.compartment_name}",

        "Allow group ${local.identity_domain_name}/${local.group_names["datasafe_reports_group_name"]} to manage data-safe-assessment-family in compartment ${module.workload_compartment.compartment_name}",
        "Allow group ${local.identity_domain_name}/${local.group_names["datasafe_reports_group_name"]} to read data-safe-report-definitions in compartment ${module.workload_compartment.compartment_name}",
        "Allow group ${local.identity_domain_name}/${local.group_names["datasafe_reports_group_name"]} to read data-safe-reports in compartment ${module.workload_compartment.compartment_name}",
        "Allow group ${local.identity_domain_name}/${local.group_names["datasafe_reports_group_name"]} to read data-safe-alerts in compartment ${module.workload_compartment.compartment_name}",
      ] : []
    ))
  }

  exadata_workload_expansion_policy_security = {
    name        = "OCI-ELZ-EXAWRK-EXP-${var.workload_prefix}-SEC-POLICY"
    description = "OCI Exadata Workload Expansion Security Policy"

    statements = [
      "Allow group ${local.identity_domain_name}/${local.group_names["exadata_infra_admin_group_name"]} to use bastion in compartment ${local.parent_compartment_names.security_compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["exadata_infra_admin_group_name"]} to manage bastion-session in compartment ${local.parent_compartment_names.security_compartment_name}",

      "Allow group ${local.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to read vaults in compartment ${local.parent_compartment_names.security_compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to inspect keys in compartment ${local.parent_compartment_names.security_compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to read vss-family in compartment ${local.parent_compartment_names.security_compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to use bastion in compartment ${local.parent_compartment_names.security_compartment_name}",
      "Allow group ${local.identity_domain_name}/${local.group_names["workload_admin_group_name"]} to manage bastion-session in compartment ${local.parent_compartment_names.security_compartment_name}",
    ]
  }

  datasafe_admin_policy = {
    name        = "OCI-ELZ-EXAWRK-EXP-${var.workload_prefix}-DTSAFE-ADMIN-POLICY"
    description = "OCI Exadata Workload Expansion Data Safe Admin Policy"

    statements = var.enable_datasafe ? [
      "Allow group ${local.identity_domain_name}/${local.group_names["datasafe_admin_group_name"]} to manage data-safe-family in compartment ${local.parent_compartment_names.environment_compartment_name}",
    ] : []
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

module "exadata_workload_expansion_policy" {
  source           = "../../modules/policies"
  compartment_ocid = module.workload_compartment.compartment_id
  policy_name      = local.exadata_workload_expansion_policy.name
  description      = local.exadata_workload_expansion_policy.description
  statements       = local.exadata_workload_expansion_policy.statements
}

module "exadata_workload_expansion_sec_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.security_compartment_id
  policy_name      = local.exadata_workload_expansion_policy_security.name
  description      = local.exadata_workload_expansion_policy_security.description
  statements       = local.exadata_workload_expansion_policy_security.statements
}

module "datasafe_admin_policy" {
  count            = var.enable_datasafe ? 1 : 0
  source           = "../../modules/policies"
  compartment_ocid = var.environment_compartment_id
  policy_name      = local.datasafe_admin_policy.name
  description      = local.datasafe_admin_policy.description
  statements       = local.datasafe_admin_policy.statements
}
