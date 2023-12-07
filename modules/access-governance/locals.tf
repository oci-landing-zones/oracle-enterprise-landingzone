locals {
  is_windows    = substr(pathexpand("~"), 0, 1) == "/" ? false : true
  agcs_tenancy  = length(var.agcs_user_tenancy_ocid_oci_system) > 0 ? var.agcs_user_tenancy_ocid_oci_system : var.tenancy_ocid
}