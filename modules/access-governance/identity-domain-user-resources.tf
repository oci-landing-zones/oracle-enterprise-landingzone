# RSA key of size 4096 bits for AGCS User API Key
resource "tls_private_key" "private_keys" {
  count     = var.use_existing_agcs_user ? 0 : 1
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "oci_identity_user" "agcs_user" {
  count          = var.use_existing_agcs_user ? 0 : 1
  depends_on     = [tls_private_key.private_keys, data.oci_identity_domains.ag_user_domain_data]
  compartment_id = var.tenancy_ocid
  description    = "Local User for AGCS access"
  name           = var.agcs_user_name
  email          = var.agcs_user_email
  freeform_tags  = { "AGCS" = "true" }
}


#AGCS User Capabilities
resource "oci_identity_user_capabilities_management" "agcs_user_tf_capabilities_management" {
  count                        = var.use_existing_agcs_user ? 0 : 1
  depends_on                   = [oci_identity_user.agcs_user]
  user_id                      = oci_identity_user.agcs_user[count.index].id
  can_use_api_keys             = "true"
  can_use_auth_tokens          = "false"
  can_use_console_password     = "false"
  can_use_customer_secret_keys = "false"
  can_use_smtp_credentials     = "false"
}

resource "oci_identity_api_key" "upload_api_key" {
  count      = var.use_existing_agcs_user ? 0 : 1
  depends_on = [oci_identity_user.agcs_user]
  key_value  = tls_private_key.private_keys[count.index].public_key_pem
  user_id    = oci_identity_user.agcs_user[count.index].id
}

resource "oci_identity_group" "agcs_group" {
  count          = var.use_existing_agcs_user ? 0 : 1
  depends_on     = [oci_identity_user.agcs_user]
  description    = "AGCS Users"
  name           = var.agcs_user_group_display_name
  compartment_id = local.agcs_tenancy
  freeform_tags  = { "AGCS" = "true" }
}

resource "oci_identity_policy" "ag-access-policy" {
  count       = var.use_existing_agcs_user ? 0 : 1
  depends_on  = [oci_identity_group.agcs_group, data.oci_identity_domains.ag_user_domain_data]
  description = "AGCS User Policies"
  name        = "${oci_identity_group.agcs_group[count.index].name}_policies"
  statements = [
    "ALLOW GROUP ${data.oci_identity_domains.ag_user_domain_data[count.index].domains[0].display_name}/${oci_identity_group.agcs_group[count.index].name} to inspect all-resources IN TENANCY",
    "ALLOW GROUP ${data.oci_identity_domains.ag_user_domain_data[count.index].domains[0].display_name}/${oci_identity_group.agcs_group[count.index].name} to manage policies IN TENANCY where any {request.permission='POLICY_UPDATE' ,request.permission='POLICY_READ', request.permission='POLICY_DELETE',target.policy.name != 'Tenant Admin Policy'}",
    "Allow GROUP ${data.oci_identity_domains.ag_user_domain_data[count.index].domains[0].display_name}/${oci_identity_group.agcs_group[count.index].name} to read audit-events IN TENANCY",
    "Allow GROUP ${data.oci_identity_domains.ag_user_domain_data[count.index].domains[0].display_name}/${oci_identity_group.agcs_group[count.index].name} to manage domains IN TENANCY",
  ]
  compartment_id = local.agcs_tenancy
  freeform_tags  = { "AGCS" = "true" }
}

resource "oci_identity_user_group_membership" "agcs_user_to_agcs_group" {
  depends_on = [oci_identity_policy.ag-access-policy]
  count      = var.use_existing_agcs_user ? 0 : 1
  group_id   = oci_identity_group.agcs_group[count.index].id
  user_id    = oci_identity_user.agcs_user[count.index].id
}