data "oci_identity_groups" "administrator_group" {
    compartment_id = var.tenancy_ocid
    name           = var.administrator_group_name
}
