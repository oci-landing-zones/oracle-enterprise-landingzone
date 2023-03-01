terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_kms_vault" "vault" {
  compartment_id = var.compartment_id
  display_name   = var.display_name
  vault_type     = var.vault_type
}

resource "oci_kms_vault_replication" "replication" {
  count          = var.enable_replication ? 1 : 0
  vault_id       = oci_kms_vault.vault.id
  replica_region = var.replica_region
}
