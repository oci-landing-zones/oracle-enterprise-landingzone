data "oci_identity_domains" "admin_domain_data" {
  compartment_id = var.admin_domain_compartment_ocid
  display_name   = var.admin_domain_name
}

data "oci_identity_domains" "ag_user_domain_data" {
  count          = var.use_existing_agcs_user ? 0 : 1
  compartment_id = local.agcs_tenancy
  display_name   = var.agcs_user_domain_name
}

#data "external" "created_instance" {
#  depends_on = [null_resource.si_creation_response]
#  program    = ["python3", "${path.module}/agcs-resources-scripts/read_instance_file.py"]
#}

data "local_file" "si_creation_response_file" {
  depends_on = [null_resource.si_creation_response]
  filename   = "${path.module}/ag_si_creation_response.txt"
}

data "local_file" "si_deletion_response_file" {
  depends_on = [null_resource.si_deletion_response]
  filename   = "${path.module}/ag_si_deletion_response.txt"
}