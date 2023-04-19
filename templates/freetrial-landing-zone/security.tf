locals {
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

    statements = var.cloud_guard_target_tenancy ? [
      "Allow service cloudguard to manage instance-family in tenancy",
      "Allow service cloudguard to manage object-family in tenancy",
      "Allow service cloudguard to manage buckets in tenancy",
      "Allow service cloudguard to manage users in tenancy",
      "Allow service cloudguard to manage policies in tenancy",
      "Allow service cloudguard to manage keys in tenancy"
      ] : [
      "Allow service cloudguard to manage instance-family in compartment ${var.home_compartment_name}",
      "Allow service cloudguard to manage object-family in compartment ${var.home_compartment_name}",
      "Allow service cloudguard to manage buckets in compartment ${var.home_compartment_name}",
      "Allow service cloudguard to manage users in compartment ${var.home_compartment_name}",
      "Allow service cloudguard to manage policies in compartment ${var.home_compartment_name}",
      "Allow service cloudguard to manage keys in compartment ${var.home_compartment_name}"
    ]
  }

  vss_policy = {
    name        = "${var.resource_label}-OCI-ELZ-VSS-Policy"
    description = "OCI Enterprise Landing Zone VSS Policy"

    statements = [
      "Allow service vulnerability-scanning-service to manage instances in compartment ${var.home_compartment_name}",
      "Allow service vulnerability-scanning-service to read compartments in compartment ${var.home_compartment_name}",
      "Allow service vulnerability-scanning-service to read vnics in compartment ${var.home_compartment_name}",
      "Allow service vulnerability-scanning-service to read vnic-attachments in compartment ${var.home_compartment_name}"
    ]
  }

  vault_policy = {
    name        = "${var.resource_label}-OCI-ELZ-Vault-Policy"
    description = "OCI Enterprise Landing Zone Vault Policy"
    statements = [
      "Allow service keymanagementservice to manage vaults in compartment ${var.home_compartment_name}"
    ]
  }

  osms_dynamic_group = {
    dynamic_group_name        = "${var.resource_label}-OCI-ELZ-DG"
    dynamic_group_description = "OCI ELZ Dynamic Group"

    general_matching_rule = <<EOT
    Any {
      instance.compartment.id  = '${module.prod_environment.compartment.security.id}',
      instance.compartment.id  = '${module.prod_environment.compartment.network.id}',
      instance.compartment.id  = '${module.prod_environment.workload_compartment_id}',
      instance.compartment.id  = '${module.prod_environment.compartment.logging.id}',
      instance.compartment.id  = '${module.home_compartment.compartment_id}'
    }
    EOT
  }

  osms_dg_policy = {
    name        = "${var.resource_label}-OCI-ELZ-OSMS-DG-Policy"
    description = "OCI Landing Zone OS Management Service Dynamic Group Policy"

    statements = [
      "Allow dynamic-group ${module.osms_dynamic_group.name} to read instance-family in compartment ${module.home_compartment.compartment_name}",
      "Allow dynamic-group ${module.osms_dynamic_group.name} to use osms-managed-instances in compartment ${module.home_compartment.compartment_name}"
    ]
  }

  osms_policy = {
    name        = "${var.resource_label}-OCI-ELZ-OSMS-Policy"
    description = "OCI Landing Zone Landing Zone OS Management Service Policy"

    statements = [
      "Allow service osms to read instances in tenancy",
    ]
  }
}

module "cloud_guard_root_policy" {
  count            = var.enable_cloud_guard   ? 1 : 0

  source           = "../../modules/policies"
  compartment_ocid = var.tenancy_ocid
  policy_name      = local.cloud_guard_policy.name
  description      = local.cloud_guard_policy.description
  statements       = local.cloud_guard_policy.statements
}

module "cloud_guard_target_policy" {
  count            = var.enable_cloud_guard   ? 1 : 0

  source           = "../../modules/policies"
  compartment_ocid = var.cloud_guard_target_tenancy ? var.tenancy_ocid : module.home_compartment.compartment_id
  policy_name      = local.cloud_guard_target_policy.name
  description      = local.cloud_guard_target_policy.description
  statements       = local.cloud_guard_target_policy.statements

  depends_on = [module.home_compartment]
}

module "vss_policy" {
  source           = "../../modules/policies"
  compartment_ocid = module.home_compartment.compartment_id
  policy_name      = local.vss_policy.name
  description      = local.vss_policy.description
  statements       = local.vss_policy.statements

  depends_on = [module.home_compartment]
}

module "vault_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.tenancy_ocid
  policy_name      = local.vault_policy.name
  description      = local.vault_policy.description
  statements       = local.vault_policy.statements

  depends_on = [module.home_compartment]
}

module "osms_dynamic_group" {
  source        = "../../modules/dynamic-group"
  tenancy_ocid  = var.tenancy_ocid
  description   = local.osms_dynamic_group.dynamic_group_description
  name          = local.osms_dynamic_group.dynamic_group_name
  matching_rule = local.osms_dynamic_group.general_matching_rule

  depends_on = [module.prod_environment, module.home_compartment]
}

module "osms_policy" {
  source = "../../modules/policies"

  compartment_ocid = var.tenancy_ocid
  policy_name      = local.osms_policy.name
  description      = local.osms_policy.description
  statements       = local.osms_policy.statements

  depends_on = [module.osms_dynamic_group]
}

module "osms_dg_policy" {
  source = "../../modules/policies"

  compartment_ocid = module.home_compartment.compartment_id
  policy_name      = local.osms_dg_policy.name
  description      = local.osms_dg_policy.description
  statements       = local.osms_dg_policy.statements
}