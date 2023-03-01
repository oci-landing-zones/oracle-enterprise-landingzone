terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

resource "oci_bastion_bastion" "bastion" {
  #Required
  bastion_type = "STANDARD"
  compartment_id = var.compartment_id
  target_subnet_id = var.target_subnet_id

  #Optional
  client_cidr_block_allow_list = var.bastion_client_cidr_block_allow_list
  name = var.bastion_name
}