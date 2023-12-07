output "si_creation" {
  depends_on = [null_resource.si_creation_response]
  value      = data.local_file.si_creation_response_file.content != "" ? jsondecode(base64decode(data.local_file.si_creation_response_file.content)) : base64decode(data.local_file.si_creation_response_file.content)
}
#
#output "si_deletion" {
#  depends_on = [null_resource.si_deletion_response]
#  value      = data.local_file.si_deletion_response_file.content != "" ? jsondecode(base64decode(data.local_file.si_deletion_response_file.content)) : base64decode(data.local_file.si_deletion_response_file.content)
#}

output "ag_user_domain" {
  depends_on = [data.oci_identity_domains.ag_user_domain_data]
  value      = data.oci_identity_domains.ag_user_domain_data[*].domains[0]
}

output "admin_domain" {
  depends_on = [data.oci_identity_domains.admin_domain_data]
  value      = data.oci_identity_domains.admin_domain_data.domains[0]
}

output "oci_identity_group" {
  value = oci_identity_group.agcs_group[*]
}