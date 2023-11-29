##########################################################################################################
# Copyright (c) 2022,2023 Oracle and/or its affiliates, All rights reserved.                             #
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl. #
##########################################################################################################

data "oci_identity_groups" "administrator_group" {
    compartment_id = var.tenancy_ocid
    name           = var.administrator_group_name
}
