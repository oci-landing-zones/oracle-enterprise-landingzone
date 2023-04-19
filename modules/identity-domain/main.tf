terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_identity_domain" "domain" {
  compartment_id            = var.compartment_id
  description               = var.domain_description
  display_name              = var.domain_display_name
  home_region               = var.domain_home_region
  license_type              = var.domain_license_type
  admin_email               = var.domain_admin_email
  admin_first_name          = var.domain_admin_first_name
  admin_last_name           = var.domain_admin_last_name
  admin_user_name           = var.domain_admin_user_name
  is_hidden_on_login        = var.domain_is_hidden_on_login
  is_notification_bypassed  = var.domain_is_notification_bypassed
  is_primary_email_required = var.domain_is_primary_email_required
}

resource "oci_identity_domain_replication_to_region" "test_domain_replication_to_region" {
  count          = var.domain_replica_region != "" ? 1 : 0
  domain_id      = oci_identity_domain.domain.id
  replica_region = var.domain_replica_region
}
