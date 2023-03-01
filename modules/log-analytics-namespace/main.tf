terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_log_analytics_namespace" "namespace" {
  compartment_id = var.compartment_id
  is_onboarded   = var.is_onboarded
  namespace      = data.oci_log_analytics_namespaces.logging_analytics_namespaces.namespace_collection[0].items[0].namespace

  depends_on = [
    time_sleep.policy_propagation_delay
  ]
}

locals {
  la_root_policy = {
    name        = "${var.resource_label}-OCI-ELZ-LA-Policy"
    description = "OCI Landing Zone Landing Zone Logging Analytics Service Policy"

    statements = [
      "define tenancy sampledata as ocid1.tenancy.oc1..aaaaaaaabmtv54v5bg45j7zd2eeat4df2bwfqkmxe2yy6ecdfrc36wloe4ia",
      "endorse group Administrators to read loganalytics-features-family in tenancy sampledata",
      "endorse group Administrators to read loganalytics-resources-family in tenancy sampledata",
      "endorse group Administrators to read compartments in tenancy sampledata",
      "allow service loganalytics to READ loganalytics-features-family in tenancy",
      "allow service loganalytics to READ compartments in tenancy",
    ]
  }
}
resource "oci_identity_policy" "policy" {
  compartment_id = var.tenancy_ocid
  description    = local.la_root_policy.description
  name           = local.la_root_policy.name
  statements     = local.la_root_policy.statements
}

resource "time_sleep" "policy_propagation_delay" {
  depends_on      = [oci_identity_policy.policy]
  create_duration = "90s"
}
