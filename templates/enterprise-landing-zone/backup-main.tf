


module "backup_prod_environment" {



  providers = {
    oci             = oci
    oci.backup_region = oci.backup_region
  }

}

module "backup_nonprod_environment" {

  providers = {
    oci             = oci
    oci.backup_region = oci.backup_region
  }
}