# -----------------------------------------------------------------------------
# Identity Domain Resources 
# -----------------------------------------------------------------------------
locals {
  identity_domain = {
    domain_display_name       = "OCI-ELZ-${var.environment_prefix}-IDT"
    domain_description        = "OCI Landing Zone ${var.environment_prefix} Identity Domain"
    domain_license_type       = "PREMIUM"
    domain_admin_user_name    = "domainadmin"
    domain_admin_first_name   = "domain"
    domain_admin_last_name    = "admin"
    domain_is_hidden_on_login = false
    group_names               = values(local.group_names)
  }

  group_names = {
    network_admin_group_name : var.network_admin_group_name != "" ? var.network_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-NET-ADMIN",
    iam_admin_group_name : var.iam_admin_group_name != "" ? var.iam_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-IDP-ADMIN",
    platform_admin_group_name : var.platform_admin_group_name != "" ? var.platform_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-PLT-ADMIN",
    ops_admin_group_name : var.ops_admin_group_name != "" ? var.ops_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-OPS-ADMIN",
    security_admin_group_name : var.security_admin_group_name != "" ? var.security_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-SEC-ADMIN",
    workload_admin_group_name : var.workload_admin_group_name != "" ? var.workload_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-WRK-ADMIN",
    application_admin_group_name : var.application_admin_group_name != "" ? var.application_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-APP-ADMIN",
    database_admin_group_name : var.database_admin_group_name != "" ? var.database_admin_group_name : "OCI-ELZ-UGP-${var.environment_prefix}-DB-ADMIN",
  }

  network_admin_policy = {
    name        = "OCI-ELZ-UGP-${var.environment_prefix}-NET-ADMIN-POLICY"
    description = "OCI Landing Zone Network Administrators Group - manages all network resources"

    statements = [
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["network_admin_group_name"]} to manage virtual-network-family in compartment ${var.network_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["network_admin_group_name"]} to manage load-balancers in compartment ${var.network_compartment_name}",
    ]
  }

  iam_admin_root_policy = {
    name        = "OCI-ELZ-UGP-${var.environment_prefix}-IDP-ADMIN-ROOT-POLICY"
    description = "OCI Landing Zone IAM Group"

    statements = [
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to manage tag-defaults in tenancy",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to manage tag-namespaces in tenancy",
    ]
  }

  iam_admin_policy = {
    name        = "OCI-ELZ-UGP-${var.environment_prefix}-IDP-ADMIN-POLICY"
    description = "OCI Landing Zone IAM Group"

    statements = [
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to inspect users in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to inspect groups in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to read policies in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to manage groups in compartment ${var.environment_compartment_name} where all {target.group.name != 'Administrators'}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to inspect identity-providers in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to manage identity-providers in compartment ${var.environment_compartment_name} where any {request.operation = 'AddIdpGroupMapping', request.operation = 'DeleteIdpGroupMapping'}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to manage dynamic-groups in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to manage authentication-policies in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to manage network-sources in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to manage quota in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to read audit-events in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to use cloud-shell in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to manage tag-defaults in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to manage tag-namespaces in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to manage users in compartment ${var.environment_compartment_name} where any {request.operation = 'ListApiKeys',request.operation = 'ListAuthTokens',request.operation = 'ListCustomerSecretKeys',request.operation = 'UploadApiKey',request.operation = 'DeleteApiKey',request.operation = 'UpdateAuthToken',request.operation = 'CreateAuthToken',request.operation = 'DeleteAuthToken',request.operation = 'CreateSecretKey',request.operation = 'UpdateCustomerSecretKey',request.operation = 'DeleteCustomerSecretKey',request.operation = 'UpdateUserCapabilities'}",
    ]
  }

  platform_admin_root_policy = {
    name        = "OCI-ELZ-UGP-${var.environment_prefix}-PLT-ADMIN-ROOT-POLICY"
    description = "OCI Landing Zone Platform Admin Root Group"

    statements = [
      "Define tenancy usage-report as ocid1.tenancy.oc1..aaaaaaaaned4fkpkisbwjlr56u7cj63lf3wffbilvqknstgtvzub7vhqkggq",
      "Endorse group ${local.identity_domain.domain_display_name}/${local.group_names["platform_admin_group_name"]} to read objects in tenancy usage-report",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["platform_admin_group_name"]} to manage usage-report in tenancy"
    ]
  }

  platform_admin_policy = {
    name        = "OCI-ELZ-UGP-${var.environment_prefix}-PLT-ADMIN-POLICY"
    description = "OCI Landing Zone Platform Admin Group"

    statements = [
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["platform_admin_group_name"]} to manage usage-report in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["platform_admin_group_name"]} to manage usage-budgets in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["platform_admin_group_name"]} to manage accountmanagement-family in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["platform_admin_group_name"]} to manage tickets in compartment ${var.environment_compartment_name}",
    ]
  }

  ops_admin_policy = {
    name        = "OCI-ELZ-UGP-${var.environment_prefix}-OPS-ADMIN-POLICY"
    description = "OCI Landing Zone Ops Admin Group"

    statements = [
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["ops_admin_group_name"]} to read metrics in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["ops_admin_group_name"]} to manage alarms in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["ops_admin_group_name"]} to manage ons-topics in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["ops_admin_group_name"]} to manage ons-subscriptions in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["ops_admin_group_name"]} to read announcements in compartment ${var.environment_compartment_name}",
    ]
  }

  security_admin_sec_policy = {
    name        = "OCI-ELZ-UGP-${var.environment_prefix}-SEC-ADMIN-SEC-POLICY"
    description = "OCI Landing Zone Security Admin Group Security Compartment"

    statements = [
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["security_admin_group_name"]} to use key-delegate in compartment ${var.security_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["security_admin_group_name"]} to manage vaults in compartment ${var.security_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["security_admin_group_name"]} to manage secret-family in compartment ${var.security_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["security_admin_group_name"]} to manage keys in compartment ${var.security_compartment_name}",
      "Allow service blockstorage, objectstorage-${var.region}, FssOc1Prod, oke, streaming to use keys in compartment ${var.security_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["security_admin_group_name"]} to manage bastion in compartment ${var.security_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["security_admin_group_name"]} to manage bastion-session in compartment ${var.security_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["security_admin_group_name"]} to read vaults in compartment ${var.security_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["security_admin_group_name"]} to inspect keys in compartment ${var.security_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["security_admin_group_name"]} to read vss-family in compartment ${var.security_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["security_admin_group_name"]} to use bastion in compartment ${var.security_compartment_name}",
    ]
  }

  security_admin_net_policy = {
    name        = "OCI-ELZ-UGP-${var.environment_prefix}-SEC-ADMIN-NET-POLICY"
    description = "OCI Landing Zone Security Admin Group Network Compartment"

    statements = [
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["security_admin_group_name"]} to read virtual-network-family in compartment ${var.network_compartment_name}",
    ]
  }

  security_admin_policy = {
    name        = "OCI-ELZ-UGP-${var.environment_prefix}-SEC-ADMIN-POLICY"
    description = "OCI Landing Zone Security Admin Group Environment Compartment"

    statements = [
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["security_admin_group_name"]} to read instance-family in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["security_admin_group_name"]} to read instance-agent-plugins in compartment ${var.environment_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["security_admin_group_name"]} to inspect work-requests in compartment ${var.environment_compartment_name}",
    ]
  }

  security_admin_root_policy = {
    name        = "OCI-ELZ-UGP-${var.environment_prefix}-SEC-ADMIN-ROOT-POLICY"
    description = "OCI Landing Zone Security Admin Group Root Compartment"

    statements = [
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["security_admin_group_name"]} to manage vss-family in tenancy",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["security_admin_group_name"]} to manage cloud-guard-family in tenancy",
    ]
  }

  workload_admin_policy = {
    name        = "OCI-ELZ-UGP-${var.environment_prefix}-WRK-ADMIN-POLICY"
    description = "OCI Landing Zone Workload Administrators Group"

    statements = [
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["workload_admin_group_name"]} to read metrics in compartment ${var.workload_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["workload_admin_group_name"]} to manage alarms in compartment ${var.workload_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["workload_admin_group_name"]} to manage ons-topics in compartment ${var.workload_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["workload_admin_group_name"]} to manage ons-subscriptions in compartment ${var.workload_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["workload_admin_group_name"]} to read announcements in compartment ${var.workload_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["workload_admin_group_name"]} to manage logging-family in compartment ${var.workload_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["workload_admin_group_name"]} to manage streams in compartment ${var.workload_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["workload_admin_group_name"]} to read audit-events in compartment ${var.workload_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["workload_admin_group_name"]} to manage logging-family in compartment ${var.workload_compartment_name}",
    ]
  }

  application_admin_policy = {
    name        = "OCI-ELZ-UGP-${var.environment_prefix}-APP-ADMIN-POLICY"
    description = "OCI Landing Zone Workload Application Group"

    statements = [
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["application_admin_group_name"]} to manage load-balancers in compartment ${var.workload_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["application_admin_group_name"]} to manage volume-family in compartment ${var.workload_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["application_admin_group_name"]} to manage object-family in compartment ${var.workload_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["application_admin_group_name"]} to manage file-family in compartment ${var.workload_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["application_admin_group_name"]} to manage instance-family in compartment ${var.workload_compartment_name}",
    ]
  }

  database_admin_policy = {
    name        = "OCI-ELZ-UGP-${var.environment_prefix}-DB-ADMIN-POLICY"
    description = "OCI Landing Zone Workload Database Group"

    statements = [
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["database_admin_group_name"]} to read autonomous-database-family in compartment ${var.workload_compartment_name}",
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["database_admin_group_name"]} to read database-family in compartment ${var.workload_compartment_name}",
    ]
  }

  announcement_subscription_policy = {
    name        = "OCI-ELZ-UGP-${var.environment_prefix}-ANNOUNCEMENT-POLICY"
    description = "OCI Landing Zone Announcement Permission Policy"

    statements = [
      "Allow group ${local.identity_domain.domain_display_name}/${local.group_names["network_admin_group_name"]}, ${local.identity_domain.domain_display_name}/${local.group_names["security_admin_group_name"]}, ${local.identity_domain.domain_display_name}/${local.group_names["platform_admin_group_name"]}, ${local.identity_domain.domain_display_name}/${local.group_names["iam_admin_group_name"]} to manage announcement-subscriptions in compartment ${var.environment_compartment_name}"
    ]
  }
}

module "identity_domain" {
  source                    = "../../modules/identity-domain"
  compartment_id            = var.security_compartment_id
  domain_description        = local.identity_domain.domain_description
  domain_display_name       = local.identity_domain.domain_display_name
  domain_home_region        = var.region
  domain_license_type       = local.identity_domain.domain_license_type
  domain_admin_email        = var.domain_admin_email
  domain_admin_user_name    = local.identity_domain.domain_admin_user_name
  domain_admin_first_name   = local.identity_domain.domain_admin_first_name
  domain_admin_last_name    = local.identity_domain.domain_admin_last_name
  domain_is_hidden_on_login = local.identity_domain.domain_is_hidden_on_login
  group_names               = local.identity_domain.group_names
}

module "network_admin_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.network_compartment_id
  policy_name      = local.network_admin_policy.name
  description      = local.network_admin_policy.description
  statements       = local.network_admin_policy.statements
}

module "iam_admin_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.environment_compartment_id
  policy_name      = local.iam_admin_policy.name
  description      = local.iam_admin_policy.description
  statements       = local.iam_admin_policy.statements
}

module "iam_admin_root_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.tenancy_ocid
  policy_name      = local.iam_admin_root_policy.name
  description      = local.iam_admin_root_policy.description
  statements       = local.iam_admin_root_policy.statements
}

module "platform_admin_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.environment_compartment_id
  policy_name      = local.platform_admin_policy.name
  description      = local.platform_admin_policy.description
  statements       = local.platform_admin_policy.statements
}

module "platform_admin_root_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.tenancy_ocid
  policy_name      = local.platform_admin_root_policy.name
  description      = local.platform_admin_root_policy.description
  statements       = local.platform_admin_root_policy.statements
}

module "ops_admin_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.environment_compartment_id
  policy_name      = local.ops_admin_policy.name
  description      = local.ops_admin_policy.description
  statements       = local.ops_admin_policy.statements
}

module "security_admin_sec_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.security_compartment_id
  policy_name      = local.security_admin_sec_policy.name
  description      = local.security_admin_sec_policy.description
  statements       = local.security_admin_sec_policy.statements
}

module "security_admin_net_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.network_compartment_id
  policy_name      = local.security_admin_net_policy.name
  description      = local.security_admin_net_policy.description
  statements       = local.security_admin_net_policy.statements
}

module "security_admin_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.environment_compartment_id
  policy_name      = local.security_admin_policy.name
  description      = local.security_admin_policy.description
  statements       = local.security_admin_policy.statements
}

module "security_admin_root_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.tenancy_ocid
  policy_name      = local.security_admin_root_policy.name
  description      = local.security_admin_root_policy.description
  statements       = local.security_admin_root_policy.statements
}

module "workload_admin_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.workload_compartment_id
  policy_name      = local.workload_admin_policy.name
  description      = local.workload_admin_policy.description
  statements       = local.workload_admin_policy.statements
}

module "application_admin_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.workload_compartment_id
  policy_name      = local.application_admin_policy.name
  description      = local.application_admin_policy.description
  statements       = local.application_admin_policy.statements
}

module "db_admin_policy" {
  source           = "../../modules/policies"
  compartment_ocid = var.workload_compartment_id
  policy_name      = local.database_admin_policy.name
  description      = local.database_admin_policy.description
  statements       = local.database_admin_policy.statements
}

# module "announcement_subscription_policy" {
#   source           = "../../modules/policies"
#   compartment_ocid = var.environment_compartment_id
#   policy_name      = local.announcement_subscription_policy.name
#   description      = local.announcement_subscription_policy.description
#   statements       = local.announcement_subscription_policy.statements
# }
