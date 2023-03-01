# ---------------------------------------------------------------------------------------------------------------------
# Get the image id of Oracle Linux
# ---------------------------------------------------------------------------------------------------------------------
data "oci_core_images" "ol_images" {
  compartment_id           = var.tenancy_ocid

  operating_system         = "Oracle Linux"
  operating_system_version = "8"
  shape                    = var.test_instance_shape
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}

data "oci_identity_availability_domains" "ad" {
  compartment_id = var.tenancy_ocid
}
