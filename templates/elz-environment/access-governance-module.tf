module "elz-access-governance" {
  source                            = "../elz-access-governance"
  count                             = var.enable_access_governance ? 1 : 0
  current_user_ocid                 = var.ag_current_user_ocid
  api_fingerprint                   = var.ag_api_fingerprint
  api_private_key_path              = var.ag_api_private_key_path
  ag_tenancy_ocid                   = var.tenancy_ocid
  ag_region                         = var.ag_region
  admin_domain_name                 = var.admin_domain_name
  admin_domain_compartment_ocid     = var.admin_domain_compartment_ocid
  service_instance_compartment_ocid = module.compartment.compartments.security.id
  service_instance_description      = var.service_instance_description
  service_instance_display_name     = var.service_instance_display_name
  ag_license_type                   = var.ag_license_type
  agcs_user_domain_name             = var.agcs_user_domain_name
  agcs_user_email                   = var.agcs_user_email
  agcs_user_fingerprint_oci_system  = var.agcs_user_fingerprint_oci_system
  agcs_user_group_display_name      = var.agcs_user_group_display_name
  agcs_user_name                    = var.agcs_user_name
  agcs_user_ocid_oci_system         = var.agcs_user_ocid_oci_system
  agcs_user_private_key             = var.agcs_user_private_key
  agcs_user_private_key_path        = var.agcs_user_private_key_path
  agcs_user_region_oci_system       = var.agcs_user_region_oci_system
  agcs_user_tenancy_ocid_oci_system = var.agcs_user_tenancy_ocid_oci_system
  namespace_service_endpoint        = var.namespace_service_endpoint
  oci_system_description            = var.oci_system_description
  oci_system_name                   = var.oci_system_name
  should_create_connected_system    = var.should_create_connected_system
  use_existing_agcs_user            = var.use_existing_agcs_user

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}