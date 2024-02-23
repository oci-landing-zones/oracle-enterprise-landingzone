# Oracle Enterprise Landing Zone Access Governance Feature

## Feature Overview
Oracle Access Governance is a cloud-native Identity Governance and Administration (IGA) solution that provides insights-based access reviews, identity analytics, and intelligence capabilities for businesses.

Oracle Access Governance provides features including:

- Visibility of enterprise compliance by providing details on who has access to what.
- Ability for reviewers to optimize user privileges through intelligent access review campaigns.
- Actionable identity intelligence by building deep insights into potential security violations that enable rapid remediation of identity and access challenges.
- Continuous compliance to meet governance and compliance requirements across many applications, workloads, infrastructures, and identity platforms.
To learn more, visit: https://docs.oracle.com/en/cloud/paas/access-governance/agoye/index.html

## Deployment Overview

The Terraform code in this folder deploys Oracle Access Governance.  It is accomplished by deploying an Oracle Access Governance Instance, creating an Oracle Access Governance User and adding a Cloud gateway connected system. This workload supports only Identity Domain Tenancy.

## Prerequisites

To deploy the Oracle Enterprise Landing Zone Workload Expansion from the Terraform CLI you will need the following prerequisites.
- [Latest Version of Terraform](https://developer.hashicorp.com/terraform/downloads) v1.7.3 or later
- [OCI Terraform provider](https://registry.terraform.io/providers/oracle/oci/latest/docs) v4.109.0 or later
- [oci - cli](https://github.com/oracle/oci-cli)

## User

The Oracle Enterprise Landing Zone should be deployed by a user who is a member of the Administrators group for the tenancy. This user needs to have an API key entry defined as described [here](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm). Once the user and API Key are defined your oci-cli config should resemble below:

```text
[DEFAULT]
user=ocid1.xxxxxx.xxxxxx.xxxxxx.....  #ocid of the user
fingerprint=xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx #user api key fingerprint
tenancy=ocid1.xxxxxx.xxxxxx.xxxxxx..... #tenancy ocid
region=us-phoenix-1 #or desired region
key_file=<path to your private keyfile> #your specific path
```


## Variables
| Variable Name                          | Description                                                                                                                                                         | Required | Default Value                                                      |
|----------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|--------------------------------------------------------------------|
| **user_ocid**                          | OCID of the Administrator.                                                                                                                                          | Yes      | None                                                               |
| **fingerprint**                        | Fingerprint of the Administrator.                                                                                                                                   | Yes      | None                                                               |
| **tenancy_ocid**                       | OCID of the Administrator's Identity Domain Tenancy.                                                                                                                | Yes      | None                                                               |
| **region**                             | Region of the Administrator.                                                                                                                                        | Yes      | None                                                               |
| **private_key_path**                   | Private Key Path of Administrator.                                                                                                                                  | Yes      | None                                                               |
| **admin_domain_name**                  | Administrator's Identity Domain Name.                                                                                                                               | Yes      | Default                                                            |
| **admin_domain_compartment_ocid**      | Compartment of Identity Domain of the Administrator.                                                                                                                | Yes      | None                                                               |
| **service_instance_compartment_ocid**  | Compartment OCID for Access Governance Instance.                                                                                                                    | Yes      | OCID of the Security compartment created by baseline Landing Zone. |
| **service_instance_description**       | Access Governance Instance Description.                                                                                                                             | Yes      | Oracle Access Governance Service Instance.                         |
| **service_instance_display_name**      | Unique Access Governance Instance Display Name.                                                                                                                     | Yes      | access-governance-instance                                         |
| **ag_license_type**                    | Access Governance Instance License Type.  Supported license types are "Access Governance for Oracle Workloads", "Access Governance for Oracle Cloud Infrastructure" | Yes      | None                                                               |
| **use_existing_agcs_user**             | Set this value to either use existing Access Governance user or create new one.                                                                                     | No       | false                                                              |
| **agcs_user_name**                     | New Access Governance User's name.                                                                                                                                  | Yes      | prod_agcs_user                                                     |
| **agcs_user_email**                    | Email address for the user.                                                                                                                                         | Yes      | None                                                               |
| **agcs_user_group_display_name**       | Group to create for Access Governance User.                                                                                                                         | Yes      | prod_agcs_group                                                    |
| **agcs_user_ocid_oci_system**          | Access Governance User's OCID.                                                                                                                                      | Yes      | None                                                               |
| **agcs_user_private_key_path**         | Private Key for Access Governance User.                                                                                                                             | Yes      | None                                                               |
| **agcs_user_fingerprint_oci_system**   | Access Governance User's Fingerprint.                                                                                                                               | Yes      | None                                                               |
| **agcs_user_region_oci_system**        | Region of the Access Governance User.                                                                                                                               | Yes      | None                                                               |
| **agcs_user_tenancy_ocid_oci_system**  | Access Governance User's Tenancy OCID.                                                                                                                              | Yes      | None                                                               |
| **oci_system_description**             | OCI Connected System Description.                                                                                                                                   | Yes      | OCI Connected System.                                              |
| **oci_system_name**                    | OCI Connected System Name.                                                                                                                                          | Yes      | Local-OCI-System                                                   |


## How to Execute

<blockquote> Currently only <b>production</b> deployment is supported via stack deployment, to deploy in <b>non-production</b> environment, run the Access Governance Module as standalone deployment. Please change the working directory to <i>oci-landing-zones/modules/access-governance</i> and enable the provider lines and disable remaining lines, fill the terraform.tfvars and follow terraform CLI commands</blockquote>

### Via Resource Manager
Deployment via Resource Manager is currently not supported.

### Via Terraform CLI (Two Deployment Scenarios)
#### Deployment Scenario 1: use_existing_agcs_user = false:
1. Enter required variables in terraform.tfvars, for examples refer to templates/elz-access-governance/examples/new_agcs_user.tfvarexample
2. terraform init.
3. terraform plan.
4. terraform apply.

##### Oracle Access Governance Deployment: Access Governance Service Instance:
An Access Governance Service instance will be deployed in the security compartment.

##### Oracle Access Governance Deployment: AGCS Group:
A group will be created called AGCS Group, which is meant to have AGCS user and policies related to Access Governance functionalities.

##### Oracle Access Governance Deployment: AGCS User:
AGCS User which will be created in Default domain as the user needs visibility into all domains and their resources for policy review and group review. This is the primary user used for governing the OCI IAM.

##### Oracle Access Governance Deployment: AGCS User Group Policy statements:
1. `ALLOW GROUP <domain>/<group> to inspect all-resources IN TENANCY`
2. `ALLOW GROUP <domain>/<group> to manage policies IN TENANCY where any {request.permission='POLICY_UPDATE' ,request.permission='POLICY_READ', request.permission='POLICY_DELETE',target.policy.name != 'Tenant Admin Policy'}`
3. `ALLOW GROUP <domain>/<group> to read audit-events IN TENANCY`
4. `ALLOW GROUP <domain>/<group> to manage domains IN TENANCY`


#### Deployment Scenario 2: use_existing_agcs_user = true:
1. Enter required variables in terraform.tfvars, for examples refer to templates/elz-access-governance/examples/existing_agcs_user.tfvarexample
2. terraform init.
3. terraform plan.
4. terraform apply.

`use_existing_agcs_user`            = `true`<br>
`agcs_user_private_key_path`        = `"<path to Access Governance User's private key pem file>"`<br>
`agcs_user_ocid_oci_system`         = `"ocid1.user.oc1..xyz"`<br>
`agcs_user_fingerprint_oci_system`  = `"<fingerprint>"`<br>

<blockquote> The above user needs to be in <b>Default</b> domain with below policy statements.</blockquote>

1. `ALLOW GROUP <domain>/<group> to inspect all-resources IN TENANCY`
2. `ALLOW GROUP <domain>/<group> to manage policies IN TENANCY where any {request.permission='POLICY_UPDATE' ,request.permission='POLICY_READ', request.permission='POLICY_DELETE',target.policy.name != 'Tenant Admin Policy'}` 
3. `ALLOW GROUP <domain>/<group> to read audit-events IN TENANCY`
4. `ALLOW GROUP <domain>/<group> to manage domains IN TENANCY`


##### Oracle Access Governance Deployment: Access Governance Service Instance:
An Access Governance Service instance will be deployed in the security compartment.

##### Oracle Access Governance Deployment: OCI system on Access Governance Instance:
Cloud gateway system will be added as connected system to the service instance.

## License
Copyright (c) 2023, Oracle and/or its affiliates.

Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

See [LICENSE](../../LICENSE) for more details.

## Known Issues
None.