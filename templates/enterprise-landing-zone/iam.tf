# -----------------------------------------------------------------------------
# Compartment Resources 
# -----------------------------------------------------------------------------
locals {
  home_compartment = {
    description = "Enterprise Landing Zone Home Compartment"
  }
}

module "home_compartment" {
  source = "../../modules/compartment"

  compartment_parent_id     = var.tenancy_ocid
  compartment_name          = var.home_compartment_name
  compartment_description   = local.home_compartment.description
  enable_compartment_delete = var.enable_compartment_delete

  providers = {
    oci = oci.home_region
  }
}

module "break_glass_users" {
  for_each     = { for index, email in var.break_glass_user_email_list : index => email }
  source       = "../../modules/break_glass_user"
  tenancy_ocid = var.tenancy_ocid

  break_glass_user_index = each.key
  break_glass_user_email = each.value

  providers = {
    oci = oci.home_region
  }
}

# -----------------------------------------------------------------------------
# Authentication Policy
# -----------------------------------------------------------------------------
locals {
  authentication_policy = {
    authentication_policy_password_policy_is_lowercase_characters_required = true
    authentication_policy_password_policy_is_numeric_characters_required   = true
    authentication_policy_password_policy_is_special_characters_required   = true
    authentication_policy_password_policy_is_uppercase_characters_required = true
    authentication_policy_password_policy_is_username_containment_allowed  = false
    authentication_policy_password_policy_minimum_password_length          = 14
  }
}

module "authentication_policy" {
  source                                                                 = "../../modules/authentication-policy"
  tenancy_ocid                                                           = var.tenancy_ocid
  authentication_policy_password_policy_is_lowercase_characters_required = local.authentication_policy.authentication_policy_password_policy_is_lowercase_characters_required
  authentication_policy_password_policy_is_numeric_characters_required   = local.authentication_policy.authentication_policy_password_policy_is_numeric_characters_required
  authentication_policy_password_policy_is_special_characters_required   = local.authentication_policy.authentication_policy_password_policy_is_special_characters_required
  authentication_policy_password_policy_is_uppercase_characters_required = local.authentication_policy.authentication_policy_password_policy_is_uppercase_characters_required
  authentication_policy_password_policy_is_username_containment_allowed  = local.authentication_policy.authentication_policy_password_policy_is_username_containment_allowed
  authentication_policy_password_policy_minimum_password_length          = local.authentication_policy.authentication_policy_password_policy_minimum_password_length
}
