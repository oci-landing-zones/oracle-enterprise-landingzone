## Oracle Enterprise Landing Zone Workload Expansion Configuration Guide

This configuration guide will detail the required and available configurations needed to deploy an Oracle Enterprise Landing Zone(OELZ) 2.0 Workload Expansion on Oracle Cloud Infrastructure. 

## Prerequisites

Oracle Enterprise Landing Zone(OELZ) stack will be fully deployed on the OCI Tenanacy.


## Minimum Required Configuration

Deployment of the OELZ is controlled by several Terraform [input variables](README.md#inputs), however most of these have sensible default values. Here are the minimum required configurations to deploy a OELZ Workload Expansion:

### Basic Terraform Connection Information
The required provider variables for the OELZ:

| Name                                                                                                 | Description                                                  | Type     | Default | Required |
| ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------------ | -------- | ------- |:--------:|
| <a name="input_current_user_ocid"></a> [current\_user\_ocid](#input\_current\_user\_ocid)            | The ID of user to deploy the OELZ.                   | `string` | `""`    |   yes    |
| <a name="input_api_fingerprint"></a> [api\_fingerprint](#input\_api\_fingerprint)                    | The API fingerprint which can be retrieved from the console. | `string` | `""`    |   yes    |
| <a name="input_api_private_key_path"></a> [api\_private\_key\_path](#input\_api\_private\_key\_path) | The local path to the API private key                        | `string` | `""`    |   yes    |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid)                             | The ID of tenancy                                            | `string` | n/a     |   yes    |
| <a name="input_region"></a> [region](#input\_region)                                                 | The OCI region to deploy the OELZ resources to.      | `string` | n/a     |   yes    |


## Compartment Module

This architecture diagram illustrates the compartments for Enterprise LZ deploys Workload Expansion.

![](../../images/lz-v2.0.png)

The OELZ Workload Expansion will create L3 workload compartment on the user defined Parent Compartment OCID . 

The required arguments for OELZ Workload Compartment:

| Name                                                                                                              | Description                                                                               | Type     | Default                           | Required |
|-------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------| -------- |-----------------------------------| :------: |
| <a name="input_enable_compartment_delete"></a> [enable\_compartment\_delete](#input\_enable\_compartment\_delete) | Set to true to allow the compartments to delete on terraform destroy.                     | `bool`   | `true`                            |    yes    |
| <a name="workload_compartment_name"></a> [workload\_compartment\_name](#input\_home\_compartment\_name)           | The name of the workload compartment under which all Workload resources will be deployed. | `string` | `"OCI-ELZ-Workload1-[Region]-01"` |    yes    |
| <a name="environment_compartment_id"></a> [environment\_compartment\_id](#input\_home\_compartment\_name)         | The name of parent compartment where workload compartment will be created                 | `string` | `"OCID Value"`                    |    yes    |
| <a name="workload_expansion_flag "></a> [workload\_expansion\_flag](#input\_home\_compartment\_name)              | Flag to enable workload expansion                                                         | `bool` | `true`                            |    yes    |
| <a name="environment_prefix"></a> [environment\_prefix](#input\_home\_compartment\_name)                          | The unique prefix for environment created in baseline stack (e.g. N, P)                   | `string` |                                   |    yes    |


## Network Module

The required arguments for OELZ Workload Network:
* **OELZ Workload Spoke VCN Related Variables**

| Name                                                                                                              | Description                                                                               | Type     | Default        | Required |
| ----------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | -------- | -------------- | :------: |
| <a name="workload_prefix"></a> [workload\_prefix](#workload\_prefix) | Workload Prefix.                     | `string`   | `"WRK1"`        |    yes    |
| <a name="vcn_display_name"></a> [vcn\_display\_name](#vcn\_display\_name) | Workload Spoke VCN Display Name.                     | `string`   | `"OCI-ELZ-${var.workload_prefix}-EXP-SPK-VCN-${local.region_key[0]}"`|    no   |
| <a name="workload_spoke_vcn_cidr"></a> [workload\_spoke\_vcn\_cidr](#workload\_spoke\_vcn\_cidr) | Workload Spoke VCN IPv4 CIDR Block.                     | `string`   |                |    yes   |
| <a name="vcn_dns_label"></a> [vcn\_dns\_label](#vcn\_dns\_label)             | Workload Spoke VCN DNS Label. | `string` | `"wrkspokevcn"` |    yes    |

* **OELZ Workload Spoke VCN Subnet Related Variables** 
  
| Name                                                                                                              | Description                                                                               | Type     | Default              | Required |
| ----------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | -------- | -------------------- | :------: |
| <a name="workload_private_spoke_subnet_web_display_name"></a> [workload\_private\_spoke\_subnet\_web\_display\_name](#workload\_private\_spoke\_subnet\_web\_display\_name)             | Workload Spoke VCN Web Subnet Display Name | `string` | `"OCI-ELZ-${var.workload_prefix}-EXP-SPK-VCN-SUB-${local.region_key[0]}-001"` |    no    |
| <a name="workload_private_spoke_subnet_app_display_name"></a> [workload\_private\_spoke\_subnet\_app\_display\_name](#workload\_private\_spoke\_subnet\_app\_display\_name)             | Workload Spoke VCN App Subnet Display Name | `string` | `"OCI-ELZ-${var.workload_prefix}-EXP-SPK-VCN-SUB-${local.region_key[0]}-002"` |    no    |
| <a name="workload_private_spoke_subnet_db_display_name"></a> [workload\_private\_spoke\_subnet\_db\_display\_name](#workload\_private\_spoke\_subnet\_db\_display\_name)             | Workload Spoke VCN DB Subnet Display Name | `string` | `"OCI-ELZ-${var.workload_prefix}-EXP-SPK-VCN-SUB-${local.region_key[0]}-003"` |    no    |
| <a name="workload_private_spoke_subnet_web_cidr_block"></a> [workload\_private\_spoke\_subnet\_web\_cidr\_block](#workload\_private\_spoke\_subnet\_web\cidr\_block)             | Workload Spoke VCN Web Subnet CIDR BLOCK | `string` | `""(Valid IPv4 Address)` |    yes    |
| <a name="workload_private_spoke_subnet_app_cidr_block"></a> [workload\_private\_spoke\_subnet\_app\_cidr\_block](#workload\_private\_spoke\_subnet\_app\cidr\_block)             | Workload Spoke VCN App Subnet CIDR BLOCK | `string` | `""(Valid IPv4 Address)` |    yes    |
| <a name="workload_private_spoke_subnet_db_cidr_block"></a> [workload\_private\_spoke\_subnet\_db\_cidr\_block](#workload\_private\_spoke\_subnet\_db\cidr\_block)             | Workload Spoke VCN Db Subnet CIDR BLOCK | `string` | `""(Valid IPv4 Address)` |    yes    |
| <a name="workload_private_spoke_subnet_web_dns_label"></a> [workload\_private\_spoke\_subnet\_web\_dns\_label](#workload\_private\_spoke\_subnet\_web\_dns\_label)             | Workload Spoke VCN Web Subnet DNS Label | `string` | `"wrkweblabel"` |    yes    |
| <a name="workload_private_spoke_subnet_app_dns_label"></a> [workload\_private\_spoke\_subnet\_app\_dns\_label](#workload\_private\_spoke\_subnet\_app\_dns\_label)             | Workload Spoke VCN App Subnet DNS Label | `string` | `"wrkapplabel"` |    yes    |
| <a name="workload_private_spoke_subnet_db_dns_label"></a> [workload\_private\_spoke\_subnet\_db\_dns\_label](#workload\_private\_spoke\_subnet\_db\_dns\_label)             | Workload Spoke VCN Db Subnet DNS Label | `string` | `"wrkdblabel"` |    yes    |

* **OELZ Workload Spoke VCN Gateway Related Variables**

| Name                                                                                                              | Description                                                                               | Type     | Default              | Required |
| ----------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | -------- | -------------------- | :------: |
| <a name="enable_nat_gateway_spoke"></a> [enable\_nat\_gateway\_spoke](#enable\_nat\_gateway\_spoke)             | Workload Spoke VCN Enable Nat-Gateway | `bool` | `false` |    yes    |
| <a name="nat_gateway_display_name"></a> [nat\_gateway\_display\_name](#nat\_gateway\_display\_name)             | Workload Spoke VCN  Nat-Gateway Display Name | `string` | `"OCI-ELZ-${var.workload_prefix}-EXP-SPK-NAT-${local.region_key[0]}"` |    no    |
| <a name="enable_service_gateway_spoke"></a> [enable\_service\_gateway\_spoke](#enable\_service\_gateway\_spoke)             | Workload Spoke VCN Enable Service Gateway | `bool` | `false` |    yes    |
| <a name="service_gateway_display_name"></a> [service\_gateway\_display\_name](#service\_gateway\_display\_name)             | Workload Spoke VCN  Service Gateway Display Name | `string` | `"OCI-ELZ-${var.workload_prefix}-EXP-SPK-SGW-${local.region_key[0]}"` |    no    |

* **OELZ Workload Spoke VCN Route Table and Security List Related Variables** 

| Name                                                                                                              | Description                                                                               | Type     | Default              | Required |
| ----------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | -------- | -------------------- | :------: |
| <a name="hub_public_subnet_cidr_block"></a> [hub\_public\_subnet\_cidr\_block](#hub\_public\_subnet\_cidr\_block)             | Provide Hub Public Subnet IPv4 CIDR Block. | `string` | `""(Valid IPv4 CIDR Block)` |    yes    |
| <a name="hub_private_subnet_cidr_block"></a> [hub\_private\_subnet\_cidr\_block](#hub\_private\_subnet\_cidr\_block)             | Provide Hub Private Subnet IPv4 CIDR Block. | `string` | `""(Valid IPv4 CIDR Block)` |    yes    |

## IAM

The required arguments Workload Expansion IAM:

| Name                                                                                                              | Description                                                                               | Type     | Default              | Required |
| ----------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | -------- | -------------------- | :------: |
| <a name="workload_admin_group_name"></a> [workload\_admin\_group\_name](#workload\_admin\_group\_name)             | Provide Workload Admin Group Name. | `string` | `"OCI-ELZ-UGP-[workload_prefix]-WRK-ADMIN"` |    yes    |
| <a name="application_admin_group_name"></a> [application\_admin\_group\_name](#application\_admin\_group\_name)             | Provide Workload Application Admin Group Name. | `string` | `"OCI-ELZ-UGP-[workload_prefix]-APP-ADMIN"` |    yes    |
| <a name="database_admin_group_name"></a> [database\_admin\_group\_name](#database\_admin\_group\_name)             | Provide Workload DB Admin Group Name. | `string` | `"OCI-ELZ-UGP-[workload_prefix]-DB-ADMIN"` |    yes    |

## Policy

The required arguments Workload Expansion Policy:

| Name                                                                                                 | Description                        | Type     | Default              | Required |
|------------------------------------------------------------------------------------------------------|------------------------------------| -------- | -------------------- | :------: |
| <a name="security_compartment_name"></a> [security\_compartment\_name](#security\_compartment\_name) | Provide Security Compartment Name. | `string` | `""` |    yes    |
| <a name="security_compartment_ocid"></a> [security\_compartment\_ocid](#security\_compartment\_ocid) | Provide Security Compartment OCID. | `string` | `""` |    yes    |
| <a name="identity_domain_name"></a> [identity\_domain\_name](#security\_compartment\_name)           | Identity Domain Name.              | `string` | `""` |    yes    |
| <a name="identity_domain_id"></a> [identity\_domain\_ocid](#security\_compartment\_ocid)             | Identity Domain OCID.              | `string` | `""` |    yes    |

## Monitoring

These are the configuration options for Workload Monitoring: 

| Name                                                                                                           | Description                                         | Type           | Default | Required |
|----------------------------------------------------------------------------------------------------------------|-----------------------------------------------------|----------------|---------|:--------:|
| <a name="input_workload_topic_endpoints"></a> [workload\_topic\_endpoints](#input\_workload\_topic\_endpoints) | List of email addresses for Workload notifications. | `list(string)` | `[]`    | no |
| <a name="input_workload_name"></a> [workload\_name](#input\_workload\_name)                                    | Prefix to avoid name conflicts in Topic             | `string`       | `W`     | no |
| <a name="input_enable_network_monitoring_alarms"></a> [enable_network_monitoring_alarms](#input\_workload\_name)                                    | Enable network alarm in workload expansion          | `bool`         | `false` | no |
| <a name="input_enable_security_monitoring_alarms"></a> [enable_security_monitoring_alarms](#input\_workload\_name)                                    | Enable security alarm in workload expansion         | `bool`         | `false` | no |
| <a name="input_enable_workload_monitoring_alarms"></a> [enable_enable_workload_monitoring_alarms](#input\_workload\_name)                                    | Enable workload alarm in workload expansion         | `bool`         | `false` | no |