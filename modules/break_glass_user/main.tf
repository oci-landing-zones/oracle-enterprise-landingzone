terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "random_id" "user" {
  byte_length = 4
}

resource "oci_identity_user" "break_glass_user" {
  compartment_id = var.tenancy_ocid
  description    = "Break glass user ${var.break_glass_user_index}"
  name           = "Break_Glass_User_${var.break_glass_user_index}_${random_id.user.hex}"
  email          = var.break_glass_user_email
}

# ---------------------------------------------------------------------------------------------------------------------
# Break Glass User Admin Group Membership
# ---------------------------------------------------------------------------------------------------------------------
resource "oci_identity_user_group_membership" "administrator_group_membership" {
  group_id = data.oci_identity_groups.administrator_group.groups[0].id
  user_id  = oci_identity_user.break_glass_user.id
}