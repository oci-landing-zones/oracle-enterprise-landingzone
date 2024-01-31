# Access Governance Landing Zone

## Overview

The terraform code in this folder deploys Oracle Access Governance.  It is accomplished by deploying an Oracle Access Governance Instance, creating an Oracle Access Governance User and add OCI connected system.


## Variables
| Variable Name                          | Description                                                                     | Required | Default Value |
|----------------------------------------|---------------------------------------------------------------------------------|----------|---------------|
| **user_ocid**                          | OCID of the Administrator.                                                      | Yes      | None          |
| **fingerprint**                        | Fingerprint of the Administrator.                                               | Yes      | None          |
| **tenancy_ocid**                       | OCID of the Administrator's Tenancy.                                            | Yes      | None          |
| **region**                             | Region of the Administrator.                                                    | Yes      | None          |
| **private_key_path**                   | Private Key Path of Administrator.                                              | Yes      | None          |
| **admin_domain_name**                  | Administrator's Identity Domain Name.                                           | Yes      | None          |
| **namespace_service_endpoint**         | If Access Governance instance needs to be created in a namespace.               | Yes      | None          |
| **service_instance_compartment_ocid**  | Compartment OCID for Access Governance Instance.                                | Yes      | None          |
| **service_instance_description**       | Access Governance Instance Description.                                         | Yes      | None          |
| **service_instance_display_name**      | Access Governance Instance Display Name.                                        | Yes      | None          |
| **ag_license_type**                    | Access Governance Instance License Type.                                        | Yes      | None          |
| **agcs_user_domain_name**              | Domain where Access Governance User will be created.                            | Yes      | None          |
| **use_existing_agcs_user**             | Set this value to either use existing Access Governance user or create new one. | No       | false         |
| **agcs_user_name**                     | New Access Governance User's name.                                              | Yes      | None          |
| **agcs_user_email**                    | Email address for the user.                                                     | Yes      | None          |
| **agcs_user_group_display_name**       | Group to create for Access Governance User.                                     | Yes      | None          |
| **agcs_user_ocid_oci_system**          | Access Governance User's OCID.                                                  | Yes      | None          |
| **agcs_user_private_key_path**         | Private Key for Access Governance User.                                         | Yes      | None          |
| **agcs_user_fingerprint_oci_system**   | Access Governance User's Fingerprint.                                           | Yes      | None          |
| **agcs_user_region_oci_system**        | Region of the Access Governance User.                                           | Yes      | None          |
| **agcs_user_tenancy_ocid_oci_system**  | Access Governance User's Tenancy OCID.                                          | Yes      | None          |
| **oci_system_description**             | OCI Connected System Description.                                               | Yes      | None          |
| **oci_system_name**                    | OCI Connected System Name.                                                      | Yes      | None          |

## How to execute
### Via Resource Manager
1. [![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/oracle-quickstart/oci-landing-zones/releases/tag/v2.2.0)
*If you are logged into your OCI tenancy, the button will take you directly to OCI Resource Manager where you can proceed to deploy. If you are not logged, the button takes you to Oracle Cloud initial page where you must enter your tenancy name and login to OCI.*
2. Under **Working directory** select the directory *templates/elz-access-governance*
3. Click Next.
4. Enter the values for required variables.
5. Click Next.
6. Click Next.
7. Click Apply.

### Via Terraform CLI
1. Enter required variables in terraform.tfvars, for examples refer examples/tfvars.
2. terraform init.
3. terraform plan.
4. terraform apply.

## License
Copyright (c) 2023, Oracle and/or its affiliates.

Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

See [LICENSE](../../LICENSE) for more details.

## Known Issues
None.