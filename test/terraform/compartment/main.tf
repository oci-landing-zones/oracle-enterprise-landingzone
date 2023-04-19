locals {
  home_compartment = {
    description = "Enterprise Landing Zone Home Compartment"
  }
}

module "home_compartment" {
  source = "../../../modules/compartment"

  compartment_parent_id     = var.tenancy_ocid
  compartment_name          = var.home_compartment_name
  compartment_description   = local.home_compartment.description
  enable_compartment_delete = var.enable_compartment_delete

  providers = {
    oci = oci.home_region
  }
}

module "compartment" {
  source                       = "../../../templates/elz-compartment"
  tenancy_ocid                 = var.tenancy_ocid
  region                       = var.region
  environment_prefix           = var.environment_prefix
  enable_compartment_delete    = var.enable_compartment_delete
  home_compartment_id          = module.home_compartment.compartment_id # changed
  environment_compartment_name = var.environment_compartment_name
  enable_tf_state_backup       = var.enable_tf_state_backup
  enable_logging               = var.enable_logging

  providers = {
    oci             = oci
    oci.home_region = oci.home_region
  }
}
