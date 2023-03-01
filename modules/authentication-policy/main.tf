terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_identity_authentication_policy" "authentication_policy" {
  compartment_id = var.tenancy_ocid

  password_policy {

    is_lowercase_characters_required = var.authentication_policy_password_policy_is_lowercase_characters_required
    is_numeric_characters_required = var.authentication_policy_password_policy_is_numeric_characters_required
    is_special_characters_required = var.authentication_policy_password_policy_is_special_characters_required
    is_uppercase_characters_required = var.authentication_policy_password_policy_is_uppercase_characters_required
    is_username_containment_allowed = var.authentication_policy_password_policy_is_username_containment_allowed
    minimum_password_length = var.authentication_policy_password_policy_minimum_password_length
  }
}