## Oracle Enterprise Landing Zone Configuration Guide

This configuration guide will detail the required and available configurations needed to deploy an Oracle Enterprise Landing Zone(OELZ) on Oracle Cloud Infrastructure. 

## Prerequisites

The Oracle Enterprise Landing Zone is designed to be deployed to a tenancy owned by the individual Tenancy Administrator. The user deploying the OELZ must be a member of the Administrators group for the tenancy.  The tenancy must have the required Resource Limits and have the Logging Analytics feature turned on.  Detailed information on these prerequisites, and how to check that your tenancy meets them, and enable needed features can be found in the [Implementation Document](Implementation.md)


## Minimum Required Configuration

Deployment of the OELZ is controlled by several Terraform [input variables](README.md#inputs), however most of these have sensible default values. Here are the minimum required configurations to deploy a OELZ:

### Basic Terraform Connection Information
The required provider variables for the OELZ:

| Name                                                                                                 | Description                                                  | Type     | Default | Required |
| ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------------ | -------- | ------- | :------: |
| <a name="input_current_user_ocid"></a> [current\_user\_ocid](#input\_current\_user\_ocid)            | The ID of user to deploy the OELZ.                   | `string` | `""`    |    no    |
| <a name="input_api_fingerprint"></a> [api\_fingerprint](#input\_api\_fingerprint)                    | The API fingerprint which can be retrieved from the console. | `string` | `""`    |    no    |
| <a name="input_api_private_key"></a> [api\_private\_key](#input\_api\_private\_key)                  | The API private key                                          | `string` | `""`    |    no    |
| <a name="input_api_private_key_path"></a> [api\_private\_key\_path](#input\_api\_private\_key\_path) | The local path to the API private key                        | `string` | `""`    |    no    |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid)                             | The ID of tenancy                                            | `string` | n/a     |   yes    |
| <a name="input_region"></a> [region](#input\_region)                                                 | The OCI region to deploy the OELZ resources to.      | `string` | n/a     |   yes    |
| <a name="input_resource_label"></a> [resource\_label](#input\_resource\_label)                       | The prefix used to avoid naming conflict                     | `string` | n/a     |    no    |


## Compartment Module

This architecture diagram illustrates the compartments Enterprise LZ deploys.

![Architecture](<../../images/LZ-v2.0.png> "Architecture")

The OELZ Home Compartment would be created in enterprise-landing-zone. The other
compartments would be created in elz-environment and in elz-workload.

The required arguments for OELZ Home Compartment:
* **compartment_parent_id**: the OCID of compartment/tenancy that you create the OELZ in
* **compartment_name**: the name of OELZ home compartment
* **compartment_description**: the description of OELZ home compartment
* **enable_compartment_delete**: unless enable_delete is explicitly set to true, Terraform will not delete compartments on destroy

To configure the compartment the required user inputs are:

| Name                                                                                                              | Description                                                                               | Type     | Default              | Required |
| ----------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | -------- | -------------------- | :------: |
| <a name="input_enable_compartment_delete"></a> [enable\_compartment\_delete](#input\_enable\_compartment\_delete) | Set to true to allow the compartments to delete on terraform destroy.                     | `bool`   | `true`               |    no    |
| <a name="input_home_compartment_name"></a> [home\_compartment\_name](#input\_home\_compartment\_name)             | The name of the home compartment under which all OELZ resources will be deployed. | `string` | `"OCI-ELZ-CMP-HOME"` |    no    |

## Identity Module
Each environment will have its own identity domain. The identity domain applies to all resources under the environment compartment.
OELZ will only support the new identity domains in OCI(Henosis) and not the old IDCS domains.

Required attributes:
* Display Name: The display name of Identity Domain. Default: OCI-ELZ-<Env>-IDT
* Description: The description of Identity Domain. Default: OCI OELZ <Environment> Identity Domain
* Domain Type: Premium
* Domain Admin: Email address for the domain admin
* Compartment: OCID for the compartment where the domain will be stored. This should be the L4-Security compartment
* Tags: Optional freeform tags

### Identity Domain Configurations

* **Required Arguments/Parameters for Identity Domain**:

    | Name                                                                                                                        | Description                                                                                                                         | Type           | Default | Required |
    | --------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | -------------- | ------- | :------: |
    | <a name="input_nonprod_domain_admin_email"></a> [nonprod\_domain\_admin\_email](#input\_nonprod\_domain\_admin\_email)      | The email address for the non prod identity domain admin.                                                                           | `string`       | n/a     |   yes    |
    | <a name="input_prod_domain_admin_email"></a> [prod\_domain\_admin\_email](#input\_prod\_domain\_admin\_email)               | The email address for the prod identity domain admin.                                                                               | `string`       | n/a     |   yes    |
    | <a name="input_break_glass_user_email_list"></a> [break\_glass\_user\_email\_list](#input\_break\_glass\_user\_email\_list) | Unique list of break glass user email addresses that do not exist in the tenancy. These users are added to the Administrator group. | `list(string)` | `[]`    |    no    |


## Groups and Policies 

For control over users and user groups, a federate-able Identity Domain is created in the L4-Security Compartment for each environment. 
To do so, the user deploying the OELZ will need set up federation after the OELZ has been deployed. 

The OELZ also will create 6 different User Groups, meant for managing individual deployed environments(by default 2, prod and non-prod). 

* **Network Admin** : OCI OELZ Network Administrators Group - manages all network resources
* **SecOps Admin**: OCI OELZ Security Administrators Group
* **IAM Admin**: OCI OELZ IAM Group
* **Ops Admin**:  OCI OELZ Ops Admin Group 
* **Platform Admin**: OCI OELZ Platform Admin Group

While creating these user-groups the user inputs will be optional as there will be default value with group name, however if customer who want to setup federation, they will need to update the user-groups with the names as how those exist in their federated domain. 

* **Required Arguments/Parameters for Groups**:

    1. Prod Environment

    | Name                                                                                                                                 | Description                                                           | Type     | Default                         | Required |
    | ------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------- | -------- | ------------------------------- | :------: |
    | <a name="input_prod_network_admin_group_name"></a> [prod\_network\_admin\_group\_name](#input\_prod\_network\_admin\_group\_name)    | The group name for the OCI OELZ Network Administrators Group  | `string` | `"OCI-ELZ-UGP-<Env>-NET-ADMIN"` |    no    |
    | <a name="input_prod_ops_admin_group_name"></a> [prod\_ops\_admin\_group\_name](#input\_prod\_ops\_admin\_group\_name)                | The group name for the OCI OELZ Ops Administrators Group      | `string` | `"OCI-ELZ-UGP-<Env>-OPS-ADMIN"` |    no    |
    | <a name="input_prod_iam_admin_group_name"></a> [prod\_iam\_admin\_group\_name](#input\_prod\_iam\_admin\_group\_name)                | The group name for the OCI OELZ IAM Administrators Group      | `string` | `"OCI-ELZ-UGP-<Env>-IAM-ADMIN"` |    no    |
    | <a name="input_prod_security_admin_group_name"></a> [prod\_security\_admin\_group\_name](#input\_prod\_security\_admin\_group\_name) | The group name for the OCI OELZ Security Administrators Group | `string` | `"OCI-ELZ-UGP-<Env>-SEC-ADMIN"` |    no    |
    | <a name="input_prod_platform_admin_group_name"></a> [prod\_platform\_admin\_group\_name](#input\_prod\_platform\_admin\_group\_name) | The group name for the OCI OELZ Platform Administrators Group | `string` | `"OCI-ELZ-UGP-<Env>-PLT-ADMIN"` |    no    |

    2. NonProd Environment

    | Name                                                                                                                                          | Description                                                           | Type     | Default                         | Required |
    | --------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- | -------- | ------------------------------- | :------: |
    | <a name="input_nonprod_network_admin_group_name"></a> [nonprod\_network\_admin\_group\_name](#input\_nonprod\_network\_admin\_group\_name)    | The group name for the OCI OELZ Network Administrators Group  | `string` | `"OCI-ELZ-UGP-<Env>-NET-ADMIN"` |    no    |
    | <a name="input_nonprod_ops_admin_group_name"></a> [nonprod\_ops\_admin\_group\_name](#input\_nonprod\_ops\_admin\_group\_name)                | The group name for the OCI OELZ Ops Administrators Group      | `string` | `"OCI-ELZ-UGP-<Env>-OPS-ADMIN"` |    no    |
    | <a name="input_nonprod_iam_admin_group_name"></a> [nonprod\_iam\_admin\_group\_name](#input\_nonprod\_iam\_admin\_group\_name)                | The group name for the OCI OELZ IAM Administrators Group      | `string` | `"OCI-ELZ-UGP-<Env>-IAM-ADMIN"` |    no    |
    | <a name="input_nonprod_security_admin_group_name"></a> [nonprod\_security\_admin\_group\_name](#input\_nonprod\_security\_admin\_group\_name) | The group name for the OCI OELZ Security Administrators Group | `string` | `"OCI-ELZ-UGP-<Env>-SEC-ADMIN"` |    no    |
    | <a name="input_nonprod_platform_admin_group_name"></a> [nonprod\_platform\_admin\_group\_name](#input\_nonprod\_platform\_admin\_group\_name) | The group name for the OCI OELZ Platform Administrators Group | `string` | `"OCI-ELZ-UGP-<Env>-PLT-ADMIN"` |    no    |

The OELZ deploys policies that will grant administrative privileges to members of each of those groups over resources in their respective compartments.

## Budget and Tagging Module

The budget and tagging modules will give the ability to enable or disable budgets and tags in individual environments during the deployment as well as after the deployment without impacting the operation of LZ.
The deployment mode of the modules will be the same for each additional environment the client wants to create.

## Budget Module

The budgets module is responsible for deploying the budget component in a single environment. 
The OELZ should create following components:

* 1 Budget per environment
    * **Budget scope**: Environment (Prod/Non-Prod)

* **Required Arguments/Parameters for Budget Module**:

    * **Option on enabling or disabling Budget**: 


    | Name                                                                                                  | Description | Type   | Default | Required |
    | ----------------------------------------------------------------------------------------------------- | ----------- | ------ | ------- | :------: |
    | <a name="input_nonprod_enable_budget"></a> [nonprod\_enable\_budget](#input\_nonprod\_enable\_budget) | n/a         | `bool` | n/a     |   yes    |
    | <a name="input_prod_enable_budget"></a> [prod\_enable\_budget](#input\_prod\_enable\_budget)          | n/a         | `bool` | n/a     |   yes    |


    1. Prod Environment

    | Name                                                                                                                                       | Description                                                                                       | Type     | Default | Required |
    | ------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------- | -------- | ------- | :------: |
    | <a name="input_prod_budget_amount"></a> [prod\_budget\_amount](#input\_prod\_budget\_amount)                                               | The amount of the budget expressed as a whole number in the currency of the customer's rate card. | `string` | `""`    |    no    |
    | <a name="input_prod_budget_alert_rule_threshold"></a> [prod\_budget\_alert\_rule\_threshold](#input\_prod\_budget\_alert\_rule\_threshold) | The threshold for the budget alert.                                                               | `string` | `""`    |    no    |
    | <a name="input_prod_domain_admin_email"></a> [prod\_domain\_admin\_email](#input\_prod\_domain\_admin\_email)                              | The email address for the prod identity domain admin.                                             | `string` | n/a     |   yes    |
    | <a name="input_prod_budget_alert_rule_message"></a> [prod\_budget\_alert\_rule\_message](#input\_prod\_budget\_alert\_rule\_message)       | The alert message for budget alerts.                                                              | `string` | `""`    |    no    |


    2. Non-Prod Environment

    | Name                                                                                                                                                | Description                                                                                       | Type     | Default | Required |
    | --------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | -------- | ------- | :------: |
    | <a name="input_nonprod_budget_amount"></a> [nonprod\_budget\_amount](#input\_nonprod\_budget\_amount)                                               | The amount of the budget expressed as a whole number in the currency of the customer's rate card. | `string` | `""`    |    no    |
    | <a name="input_nonprod_budget_alert_rule_threshold"></a> [nonprod\_budget\_alert\_rule\_threshold](#input\_nonprod\_budget\_alert\_rule\_threshold) | The threshold for the budget alert.                                                               | `string` | `""`    |    no    |
    | <a name="input_nonprod_domain_admin_email"></a> [nonprod\_domain\_admin\_email](#input\_nonprod\_domain\_admin\_email)                              | The email address for the non prod identity domain admin.                                         | `string` | n/a     |   yes    |
    | <a name="input_nonprod_budget_alert_rule_message"></a> [nonprod\_budget\_alert\_rule\_message](#input\_nonprod\_budget\_alert\_rule\_message)       | The alert message for budget alerts.                                                              | `string` | `""`    |    no    |


## Tagging Module

The tags module is responsible for deploying Tags within the L2 Environment compartment. 

The OELZ should create following components:


* Tag namespace per environment containing the following defined tags and tag defaults
  * **Cost Center**
  * **Geo Location**
  * **Environment Prefix**

* **Required Arguments/Parameters for Tagging Module**:


    1. Prod Environment 

    | Name                                                                                                                | Description                                                | Type     | Default | Required |
    | ------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- | -------- | ------- | :------: |
    | <a name="input_prod_enable_tagging"></a> [prod\_enable\_tagging](#input\_prod\_enable\_tagging)                     | Option to enable Tagging gateway in Production environment | `bool`   | `false` |    no    |
    | <a name="input_prod_cost_center_tagging"></a> [prod\_cost\_center\_tagging](#input\_prod\_cost\_center\_tagging)    | Production Cost Center.                                    | `string` | n/a     |   yes    |
    | <a name="input_prod_geo_location_tagging"></a> [prod\_geo\_location\_tagging](#input\_prod\_geo\_location\_tagging) | Production Geo Center.                                     | `string` | n/a     |   yes    |

    2. Non-Prod Environment

    | Name                                                                                                                         | Description                                                    | Type     | Default | Required |
    | ---------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------- | -------- | ------- | :------: |
    | <a name="input_nonprod_enable_tagging"></a> [nonprod\_enable\_tagging](#input\_nonprod\_enable\_tagging)                     | Option to enable Tagging gateway in Non-Production environment | `bool`   | `false` |    no    |
    | <a name="input_nonprod_cost_center_tagging"></a> [nonprod\_cost\_center\_tagging](#input\_nonprod\_cost\_center\_tagging)    | Non-ProductionGeo Location.                                    | `string` | n/a     |   yes    |
    | <a name="input_nonprod_geo_location_tagging"></a> [nonprod\_geo\_location\_tagging](#input\_nonprod\_geo\_location\_tagging) | Non-Production Geo Location.                                   | `string` | n/a     |   yes    |


# Monitoring Module

The monitoring module will enable you to actively and passively monitor resources using the Metrics and Alarms features. By Default the monitoring module will create all the components in each environment but alerts are disabled.

## Monitoring Module Known Limitation 
1. Monitoring Module will configure at least 100 Alarms, so make sure tenancy have proper service limit.

## Required Arguments/Parameters for Monitoring Module
**Production Environment**

| Variable                               | Description                             | Default Value | Usage         |
| :------------------------------------- | --------------------------------------- | ------------- | ------------- |
| prod_enable_security_monitoring_alarms | Enable Security Monitoring Alarms       | false (bool)  | Set to true   |
| prod_enable_network_monitoring_alarms  | Enable Network Monitoring Alarms        | false (bool)  | Set to true   |
| prod_enable_workload_monitoring_alarms | Enable Workload Monitoring Alarms       | false (bool)  | Set to true   |
| prod_network_topic_endpoints           | Enable Network Notifications Topic      | empty (list)  | Email Address |
| prod_secops_topic_endpoints            | Enable Security OPS Notifications Topic | empty (list)  | Email Address |
| prod_platform_topic_endpoints          | Enable Platform Notifications Topic     | empty (list)  | Email Address |
| prod_identity_topic_endpoints          | Enable Identity Notifications Topic     | empty (list)  | Email Address |

**Non-Production Environment**

| Variable                                  | Description                             | Default Value | Usage         |
| :---------------------------------------- | --------------------------------------- | ------------- | ------------- |
| nonprod_enable_security_monitoring_alarms | Enable Security Monitoring Alarms       | false (bool)  | Set to true   |
| nonprod_enable_network_monitoring_alarms  | Enable Network Monitoring Alarms        | false (bool)  | Set to true   |
| nonprod_enable_workload_monitoring_alarms | Enable Workload Monitoring Alarms       | false (bool)  | Set to true   |
| nonprod_network_topic_endpoints           | Enable Network Notifications Topic      | empty (list)  | Email Address |
| nonprod_secops_topic_endpoints            | Enable Security OPS Notifications Topic | empty (list)  | Email Address |
| nonprod_platform_topic_endpoints          | Enable Platform Notifications Topic     | empty (list)  | Email Address |
| nonprod_identity_topic_endpoints          | Enable Identity Notifications Topic     | empty (list)  | Email Address |


## Networking Module

Network Module will deploy Hub and Spoke distribution paradigm, VPN and Fastconnect on the LZ Environment. 

## Network Module Known Limitation 
* CIDR ranges which can't be used during the OELZ deployment:
    * 169.254.10.0-169.254.19.255
    * 169.254.100.0-169.254.109.255
    * 169.254.192.0-169.254.201.255
    * 100.64.0.0–100.127.255.255 (Used by Exadata X8M/X9M for the interconnect)

## Required Arguments/Parameters for Network Module

**Production Environment Variable**

1. Hub Related Variable

| Variable                         | Description                    | Default Value    | Usage                   |
| :------------------------------- | ------------------------------ | ---------------- | ----------------------- |
| prod_hub_vcn_cidr_block          | HUB VCN CIDR Block             | "" (string)      | Provide CIDR IP         |
| prod_enable_internet_gateway_hub | Enable Internet Gateway In Hub | "false" (string) | To Enable Set to "true" |
| prod_enable_service_gateway_hub  | Enable Service Gateway In Hub  | "false" (string) | To Enable Set to "true" |
| prod_enable_nat_gateway_hub      | Enable NAT Gateway In Hub      | "false" (string) | To Enable Set to "true" |


2. Spoke Related Variable

| Variable                          | Description                     | Default Value    | Usage                   |
| :-------------------------------- | ------------------------------- | ---------------- | ----------------------- |
| prod_spoke_vcn_cidr               | Spoke VCN CIDR Block            | "" (string)      | Provide CIDR IP         |
| prod_enable_service_gateway_spoke | Enable Service Gateway In Spoke | "false" (string) | To Enable Set to "true" |
| prod_enable_nat_gateway_spoke     | Enable NAT Gateway In Spoke     | "false" (string) | To Enable Set to "true" |
| prod_spoke_subnet_web_cidr_block  | Spoke Web CIDR Block            | "" (string)      | Provide CIDR IP         |
| prod_spoke_subnet_app_cidr_block  | Spoke App CIDR Block            | "" (string)      | Provide CIDR IP         |
| prod_spoke_subnet_db_cidr_block   | Spoke DB CIDR Block             | "" (string)      | Provide CIDR IP         |

3. VPN Related Variable

| Variable                            | Description                       | Default Value                 | Usage                           |
| :---------------------------------- | --------------------------------- | ----------------------------- | ------------------------------- |
| enable_vpn_or_fastconnect           | Enable VPN or Fastconnect Service | "VPN \| FASTCONNECT" (string) | Set to "VPN" or "FASTCONNECT"   |
| prod_enable_vpn                     | Enable VPN on Environment         | false (bool)                  | Set to true                     |
| prod_cpe_ip_address                 | VPN CPE IP Address                | "" (string)                   | CPE Public IP Address           |
| prod_cpe_display_name               | VPN CPE Display Name              | "" (string)                   | CPE Display Name                |
| prod_cpe_vendor                     | VPN CPE Vender                    | 0 (number)                    | Follow CPE Vendor List          |
| prod_ipsec_connection_static_routes | Ipsec Static Route                | [""] (list)                   | Onpremise IPsec Static Route    |
| prod_shared_secret                  | Shared Key for IPSec Tunnel       | "EXAMPLE" (string)            | Provide IpSec Tunnel Shared Key |
| prod_ipsec_routing_type             | Ipsec Routing Type                | "STATIC" (string)             | Set to "STATIC" or "BGP" to use |
| prod_customer_bgp_asn               | BGP ASN(IF BGP Selected)          | "" (string)                   | Provide BGP ASN                 |
| prod_bgp_cust_tunnela_ip            | CPE Side Tunnel End IP Address    | "" (string)                   | Provide IP Address              |
| prod_customer_bgp_asn               | OCI Side Tunnel End IP Address    | "" (string)                   | Provide IP Address              |


4. FastConnect Related Variable (By Design FastConnect will be deployed only on Production Environment)

| Variable                        | Description                           | Default Value                 | Usage                             |
| :------------------------------ | ------------------------------------- | ----------------------------- | --------------------------------- |
| enable_vpn_or_fastconnect       | Enable VPN or Fastconnect Service     | "VPN \| FASTCONNECT" (string) | Set to "VPN" or "FASTCONNECT"     |
| fastconnect_provider            | Enable VPN on Environment             | "" (string)                   | Follow FastConnect List           |
| virtual_circuit_bandwidth_shape | Provisioned Bandwidth                 | "1500" (string)               | Provide Bandwidth                 |
| virtual_circuit_display_name    | Provisioned VC Name                   | ""(string)                    | VC Display Name                   |
| fastconnect_routing_policy      | Fastconnect Routing Policy            | [""] (list)                   | Follow Fastconnect Routing Policy |
| virtual_circuit_type            | VC IP Address Type                    | "PRIVATE \| PUBLIC" (string)  | Provide VC Type                   |
| customer_primary_bgp_peering_ip | Customer End BGP Peering IPv4 Address | "" (string)                   | Provide IP Address                |
| oracle_primary_bgp_peering_ip   | Oracle End BGP Peering IPv4 Address   | "" (string)                   | Provide IP Address                |
| virtual_circuit_customer_asn    | VC BGP ASN                            | ""(string)                    | VC BGP ASN                        |
| customer_onprem_ip_cidr         | On Premise IP CIDR                    | [""] (list)                   | On Premise IP CIDR                |
| bgp_md5auth_key                 | Optional : BGP Authentication MD5     | ""(string)                    | Provide Key                       |
| virtual_circuit_is_bfd_enabled  | Optional : Enable BFD on VC           | false(bool)                   | To Enable Set to true             |

> FastConnect Provider List
> 
| FastConnect Provider   |
| :--------------------- |
| AT&T                   |
| Azure                  |
| Megaport               |
| QTS                    |
| CEintro                |
| Cologix                |
| CoreSite               |
| Digitial Realty        |
| EdgeConneX             |
| Epsilon                |
| Equinix                |
| InterCloud             |
| Lumen                  |
| Neutrona               |
| OMCS                   |
| OracleL2ItegDeployment |
| OracleL3ItegDeployment |
| Orange                 |
| Verizon                |
| Zayo                   |


> FastConnect Routing Policy
> 
| FastConnect Routing Policy |
| :------------------------- |
| ORACLE_SERVICE_NETWORK     |
| REGIONAL                   |
| MARKET_LEVEL               |
| GLOBAL                     |



**Non Production Environment Variable**

1. Hub Related Variable

| Variable                            | Description                    | Default Value    | Usage                   |
| :---------------------------------- | ------------------------------ | ---------------- | ----------------------- |
| nonprod_hub_vcn_cidr_block          | HUB VCN CIDR Block             | "" (string)      | Provide IP Address      |
| nonprod_enable_internet_gateway_hub | Enable Internet Gateway In Hub | "false" (string) | To Enable Set to "true" |
| nonprod_enable_service_gateway_hub  | Enable Service Gateway In Hub  | "false" (string) | To Enable Set to "true" |
| nonprod_enable_nat_gateway_hub      | Enable NAT Gateway In Hub      | "false" (string) | To Enable Set to "true" |

3. Spoke Related Variable

| Variable                             | Description                     | Default Value    | Usage                   |
| :----------------------------------- | ------------------------------- | ---------------- | ----------------------- |
| nonprod_spoke_vcn_cidr               | Spoke VCN CIDR Block            | "" (string)      | Provide IP Address      |
| nonprod_enable_service_gateway_spoke | Enable Service Gateway In Spoke | "false" (string) | To Enable Set to "true" |
| nonprod_enable_nat_gateway_spoke     | Enable NAT Gateway In Spoke     | "false" (string) | To Enable Set to "true" |
| nonprod_spoke_subnet_web_cidr_block  | Spoke Web CIDR Block            | "" (string)      | Provide IP Address      |
| nonprod_spoke_subnet_app_cidr_block  | Spoke App CIDR Block            | "" (string)      | Provide IP Address      |
| nonprod_spoke_subnet_db_cidr_block   | Spoke DB CIDR Block             | "" (string)      | Provide IP Address      |

3. VPN Related Variable

| Variable                               | Description                       | Default Value                 | Usage                           |
| :------------------------------------- | --------------------------------- | ----------------------------- | ------------------------------- |
| enable_vpn_or_fastconnect              | Enable VPN or Fastconnect Service | "VPN \| FASTCONNECT" (string) | Set to "VPN" or "FASTCONNECT"   |
| nonprod_enable_vpn                     | Enable VPN on Environment         | false (bool)                  | Set to true                     |
| nonprod_cpe_ip_address                 | VPN CPE IP Address                | "" (string)                   | CPE Public IP Address           |
| nonprod_cpe_display_name               | VPN CPE Display Name              | "" (string)                   | CPE Display Name                |
| nonprod_cpe_vendor                     | VPN CPE Vender                    | 0 (number)                    | Follow CPE Vendor List          |
| nonprod_ipsec_connection_static_routes | Ipsec Static Route                | [""] (list)                   | IPsec Static Route              |
| nonprod_shared_secret                  | Shared Key for IPSec Tunnel       | "EXAMPLE" (string)            | Provide IpSec Tunnel Shared Key |
| nonprod_ipsec_routing_type             | Ipsec Routing Type                | "STATIC" (string)             | Set to "STATIC" or "BGP" to use |
| nonprod_customer_bgp_asn               | BGP ASN(IF BGP Selected)          | "" (string)                   | Provide BGP ASN                 |
| nonprod_bgp_cust_tunnela_ip            | CPE Side Tunnel End IP Address    | "" (string)                   | Provide IP Address              |
| nonprod_customer_bgp_asn               | OCI Side Tunnel End IP Address    | "" (string)                   | Provide IP Address              |

> CPE Vendor List
> 
| Number | CPE Vendor           |
| :----- | -------------------- |
| 0      | Yamaha-RTX1210       |
| 1      | Other                |
| 2      | Cisco-9.7.1-or-later |
| 3      | Yamaha-RTX830        |
| 4      | Libreswan            |
| 5      | Fortinet             |
| 6      | NEC                  |
| 7      | Cisco-8.5+           |
| 8      | Cisco-IOS            |
| 9      | WatchGuard           |
| 10     | Juniper-MX           |
| 11     | Juniper-SRX          |
| 12     | Furukawa             |
| 13     | Check_Point          |
| 14     | Palo_Alto            |


## Hub and Spoke Network

Hub and Spoke distribution paradigm will allow workload to interconnect with each other. Hub instance will configured on shared network compartment and spoke instance will be deployed on workload compartment. 

***HUB Module***

1. **Naming Convention**

| Resource                     | Deployed Name                                 |
| :--------------------------- | --------------------------------------------- |
| Hub VCN Name                 | OCI-ELZ-VCN-\<Environment\>-HUB-\<Region\>    |
| Hub Public Subnet Name       | OCI-ELZ-VCN-\<Environment\>-HUB-\<Region\>001 |
| Hub Private Subnet Name      | OCI-ELZ-VCN-\<Environment\>-HUB-\<Region\>002 |
| Hub Internet Gateway Name*   | OCI-ELZ-IGW-\<Environment\>-HUB               |
| Hub Service Gateway Name     | OCI-ELZ-SGW-\<Environment\>-HUB               |
| Hub NAT Gateway Name         | OCI-ELZ-NGW-\<Environment\>-HUB               |
| Hub Public Route Table Name  | OCI-ELZ-RTPUB-\<Environment\>-HUB001          |
| Hub Private Route Table Name | OCI-ELZ-RTPRV-\<Environment\>-HUB002          |

2. **Route Rule**
    >Public Route Table Information
    1. If Internet Gateway is enabled, it will act as default gateway.
    2. All Spoke Subnet destination will be forwarded to DRG.

    >Private Route Table Information
    1. If NAT Gateway is enabled, it will act as default gateway.
    2. If Service Gateway is enabled , all OCI services can access Hub resources.
    3. All Spoke Subnet destination will be forwarded to DRG.

3. **Security Rule**
    1. Ingress Rule : Allow All ICMP Traffic
    2. Egress  Rule : Allow All Protocol Traffic

***Spoke Module***

1. **Naming Convention**

| Resource                   | Deployed Name                                 |
| :------------------------- | --------------------------------------------- |
| Spoke VCN Name             | OCI-ELZ-VCN-\<Environment\>-SPK-\<Region\>    |
| Spoke Web Subnet Name      | OCI-ELZ-VCN-\<Environment\>-SPK-\<Region\>001 |
| Spoke App Subnet Name      | OCI-ELZ-VCN-\<Environment\>-SPK-\<Region\>002 |
| Spoke DB Subnet Name       | OCI-ELZ-VCN-\<Environment\>-SPK-\<Region\>003 |
| Spoke Service Gateway Name | OCI-ELZ-SGW-\<Environment\>-SPK               |
| Spoke NAT Gateway Name     | OCI-ELZ-NGW-\<Environment\>-SPK               |
| Spoke Route Table          | OCI-ELZ-RTPRV-\<Environment\>-SPK001          |

2. **Route Rule**
    >Public Route Table Information
    1. If NAT Gateway is enabled, it will act as default gateway.
    2. If Service Gateway is enabled , all OCI services can access Spoke resources.
    3. All Hub Subnet destination will be forwarded to DRG.
    4. All Spoke Subnet destination will be forwarded to DRG.

3. **Security Rule**
    1. Ingress Rule : Allow All ICMP Traffic
    2. Egress  Rule : Allow All Protocol Traffic

## VPN Module

VPN Module will be deployed under Shared Infrasturture Network Compartment. IPsec connection will be deployed using Static or BGP connection.

1. **Naming Convention**

| Resource              | Deployed Name                               |
| :-------------------- | ------------------------------------------- |
| CPE Name              | OCI-ELZ-CPE-\<Environment\>-HUB-[REGION]001 |
| IPsec Connection Name | OCI-ELZ-IPC-\<Environment\>-HUB-[REGION]001 |

2. **Route Rule**
    > Route Table Information OCI-ELZ-RTPUB-\<Environment\>-HUB001 Route Will be Updated 
    1. On Premise IPSec static route will be forwarded to DRG.
    
    > Route Table Information OCI-ELZ-RTPRV-\<Environment\>-HUB001 Route Will be Updated 
    1. On Premise IPSec static route will be forwarded to DRG.
    
    > Route Table Information OCI-ELZ-RTPRV-\<Environment\>-SPK001 Route Will be Updated 
    1. On Premise IPSec static route will be forwarded to DRG.


## FastConnect Module

1. **Naming Convention**

| Resource                 | Deployed Name                               |
| :----------------------- | ------------------------------------------- |
| FastConnect Circuit Name | OCI-ELZ-FCN-\<Environment\>-HUB-[REGION]001 |

2. **Route Rule**
    > Route Table Information : OCI-ELZ-RTPUB-\<Environment\>-HUB001 Route Table Will be Updated 
    1. On Premise IP CIDR Route will be forwarded to DRG.
    
    > Route Table Information : OCI-ELZ-RTPRV-\<Environment\>-HUB001 Route Table Will be Updated 
    2. On Premise IP CIDR Route will be forwarded to DRG.
    
    > Route Table Information : OCI-ELZ-RTPRV-\<Environment\>-SPK001 Route Table Will be Updated 
    3. On Premise IP CIDR Route will be forwarded to DRG.<br /> 

3. **RPC Attachment**<br />
On Premise Subnet route will not propagate over the RPC connection to the second Hub & Spoke, and vice versa.  In order to accomplish this, we will create two separate route tables in on the DRG called "OCI-ELZ-DRG-P-HUB", one for the IPSec/VC attachment and the other for the RPC attachment and we will be specific on what types of routes to import.
    > Update DRG OCI-ELZ-DRG-\<Environment\>-HUB
    1. Create Import Route Distribution for On Prem
    2. Create Import Route Distribution for RPC
    3. Create Route Table for On Prem
    4. Create Route Table for RPC
    5. Apply the new Route Tables to the Attachments


## Security

To provide for a secure environment, the OELZ deploys several Oracle security services, such as CloudGuard to monitor for insecure cloud resource deployments, Vulnerability Scanning Service to scan compute instances for open ports and known vulnerabilities, and OS Management Service to manage updates and patches. 

To provide secure storage and key management, the OELZ deploys a Vault and a creates a Master Encryption Key stored in that vault, which can be used to encrypt data in Object Storage. 

For secure storage and future analysis of logging data, the OELZ directs all logging data, including general log data, service events, and audit logs, to secure storage. This can be secure object storage buckets created by the OELZ, and encrypted with the Master Encryption Key stored in the central Vault.

For secure access to workload resources, the OELZ deploys a Bastion in the L4 Security Compartment.


### Security Services

The OELZ deploys configurations for multiple security services. VSS (Vulnerability Scanning Service) will scan compute instances deployed in the OELZ (i.e. as part of workloads) for open ports, and known security vulnerabilities.  OSMS (OS Management Service) works with operating systems on deployed compute instances (such as Oracle Autonomous Linux) to manage patches and updates to ensure a secure environment.  

### Cloud Guard Sub Module

CloudGuard can monitor for a multitude of security conditions. The OELZ configures CloudGuard with several Oracle-managed security recipes for up-to-date best practice security monitoring.

By default, CloudGuard is configured to monitor just the resources deployed in the OELZ Home compartment, and compartments within that. An option is for CloudGuard to monitor the entire tenancy is there and it is controlled by the [cloud_guard_target_tenancy](cloud_guard_target_tenancy) variable. This is a Boolean variable that defaults to `false`. If it is set to `true` CloudGuard will be configured to monitor the entire tenancy, instead of just the OELZ Home compartment. 

Cloud Guard Target will be deployed in base compartment of both L2-Prod and L2-Non-Prod environments along with related IAM policies. All Oracle managed responder recipes will reside in L4 Security compartment of each environment.

The **target_detector_recipes** which are Oracle managed:

* OCI Config Detector Recipes
* OCI Threat Detector Recipes
* OCI Activity Detector Recipe

The **target_responder_recipes**: OCI Responder Recipe (enabling CloudGuard events and other responds)

For further details on CloudGuard, see the [Cloud Guard documentation](https://docs.oracle.com/en-us/iaas/cloud-guard/home.htm).

* **Required Arguments/Parameters Under Cloud Guard Module**:

    | Name                                                                                                                   | Description                                                                                           | Type   | Default | Required |
    | ---------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ------ | ------- | :------: |
    | <a name="input_enable_cloud_guard"></a> [enable\_cloud\_guard](#input\_enable\_cloud\_guard)                           | true if you don't have cloud guard enabled, false if you've already have cloud guard enabled.         | `bool` | `true`  |    no    |
    | <a name="input_cloud_guard_target_tenancy"></a> [cloud\_guard\_target\_tenancy](#input\_cloud\_guard\_target\_tenancy) | true if cloud guard targets to tenancy, false if cloud guard targets to OELZ home compartment | `bool` | `false` |    no    |

### Bastion Sub Module

Bastion service is created in the L4 Security Compartment within the L2 prod Compartment and second one in the L4 Security Compartment within the L2 non-Prod Compartment as depicted in the Security Architecture shown above. It allows secure access to compute resources in the respective environments. CIDR Block provided will give the address range of all the resources for which Bastion Service can host sessions for. 

* **Required Arguments/Parameters Under Bastion Module**:

    1. Prod Environment 

    | Name                                                                                                                                                                      | Description                                                                                                     | Type           | Default | Required |
    | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | -------------- | ------- | :------: |
    | <a name="input_prod_enable_bastion"></a> [prod\_enable\_bastion](#input\_prod\_enable\_bastion)                                                                           | Option to enable bastion service                                                                                | `bool`         | n/a     |   yes    |
    | <a name="input_prod_bastion_client_cidr_block_allow_list"></a> [prod\_bastion\_client\_cidr\_block\_allow\_list](#input\_prod\_bastion\_client\_cidr\_block\_allow\_list) | A list of address ranges in CIDR notation that you want to allow to connect to sessions hosted by this bastion. | `list(string)` | n/a     |   yes    |

    2. Non-Prod Environment

    | Name                                                                                                                                                                               | Description                                                                                                     | Type           | Default | Required |
    | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | -------------- | ------- | :------: |
    | <a name="input_nonprod_enable_bastion"></a> [nonprod\_enable\_bastion](#input\_nonprod\_enable\_bastion)                                                                           | Option to enable bastion service                                                                                | `bool`         | n/a     |   yes    |
    | <a name="input_nonprod_bastion_client_cidr_block_allow_list"></a> [nonprod\_bastion\_client\_cidr\_block\_allow\_list](#input\_nonprod\_bastion\_client\_cidr\_block\_allow\_list) | A list of address ranges in CIDR notation that you want to allow to connect to sessions hosted by this bastion. | `list(string)` | n/a     |   yes    |

### VSS Sub Module

VSS (Vulnerability Scanning Service) is part of many security services deployed under OELZ. It scans compute instances deployed in the OELZ (i.e. as part of workloads) for open ports, and other known security vulnerabilities.  

**Key Features**:

* VSS Recipes are created in L4-Security Compartment in both prod/nonprod environments to manage instances, read components and VNICs. 
* Network and agent based scanning in enabled by default
* Scans are configured with "Daily" Schedule
* Qualys integration allows to run reports on Qualys Dashboard instead of CloudGuard. This feature might be available on later releases, as it is not currently on Terraform Code Support. 

**No Input Parameters Required for VSS Module**

### OSMS Sub Module

OSMS (OS Management Service) works with operating systems on deployed compute instances (such as Oracle Autonomous Linux) to manage patches and updates to ensure a secure environment. 

**Key Features**:

* IAM Policy is created at Tenancy Level for OSMS service to emit metrics for instances in Tenancy
* Dynamic Group is created, name: ${var.resource_label}-"OCI-ELZ-DG"
* Matching Rules are created with compartment OCIDs (where instances reside), eg: L4-Security, Logging, Network, Workload and Base Compartment OCIDs
* IAM Policy for Dynamic Group is created in LZ home compartment 

**No Input Parameters Required for OSMS Module**

### Vault and Key Management Sub Module

OCI Vault service is a key management service that stores and manages master encryption keys and secrets for secure access to resources. 

**Key Features**:

* A Virtual Vault is created for secure storage of cryptographic keys within L4-Security Compartment of both Prod and NonProd Environments
* A user-manageable Master Encryption Key is also created, stored in the Vault, and is usable for encryption of data in OCI Storage Services
* Vault does support BYOK scenario and can store all user keys as well
* IAM Policy for Storage Services to use keys are created in LZ Base Compartment 

* **Required Arguments/Parameters for Vault and Key Management Module**:

    1. Prod Environment

    | Name                                                                                                                                          | Description                          | Type     | Default     | Required |
    | --------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------ | -------- | ----------- | :------: |
    | <a name="input_prod_vault_type"></a> [prod\_vault\_type](#input\_prod\_vault\_type)                                                           | The type of vault to create.         | `string` | `"DEFAULT"` |    no    |
    | <a name="input_prod_vault_replica_region"></a> [prod\_vault\_replica\_region](#input\_prod\_vault\_replica\_region)                           | the region to be created replica to. | `string` | `""`        |    no    |
    | <a name="input_prod_enable_vault_replication"></a> [prod\_enable\_vault\_replication](#input\_prod\_enable\_vault\_replication)               | Option to enable vault replication   | `bool`   | `false`     |    no    |
    | <a name="input_prod_create_master_encryption_key"></a> [prod\_create\_master\_encryption\_key](#input\_prod\_create\_master\_encryption\_key) | Option create master encryption key  | `bool`   | `true`      |    no    |


    2. Non-Prod Environment

    | Name                                                                                                                                                   | Description                          | Type     | Default     | Required |
    | ------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------ | -------- | ----------- | :------: |
    | <a name="input_nonprod_vault_type"></a> [nonprod\_vault\_type](#input\_nonprod\_vault\_type)                                                           | The type of vault to create.         | `string` | `"DEFAULT"` |    no    |
    | <a name="input_nonprod_vault_replica_region"></a> [nonprod\_vault\_replica\_region](#input\_nonprod\_vault\_replica\_region)                           | the region to be created replica to. | `string` | `""`        |    no    |
    | <a name="input_nonprod_enable_vault_replication"></a> [nonprod\_enable\_vault\_replication](#input\_nonprod\_enable\_vault\_replication)               | Option to enable vault replication   | `bool`   | `false`     |    no    |
    | <a name="input_nonprod_create_master_encryption_key"></a> [nonprod\_create\_master\_encryption\_key](#input\_nonprod\_create\_master\_encryption\_key) | Option create master encryption key  | `bool`   | `true`      |    no    |


### Logging

The OELZ sets up secure storage of all log data generated by resources and services in the OELZ. For both environments in L2-Prod and L2-NonProd compartment a logging compartment **“L3-Logging Compartment”** is created. This compartment hosts the below listed 3 immutable storage buckets:

* **AuditLogs_standard** (for audit logs)
* **DefaultLogs_standard** (for general logging)
* **ServiceEvents_standard** (for service events)

These buckets are encrypted with the Master Encryption Key(MEK) stored in the vault. Retention policies are also applied to these buckets to manage data retention, disallowing deletion, or modifications of data for a configurable time-period. 

Default Log group (Name: Default_Group) is created is L4-Security compartment and service logs for all supported services (VCN Flow logs, Object Storage etc.) are enabled and stored in L3-Logging compartment.

All the events in OELZ environment are streamed to standard object storage. The Stream Pool is created in L4-Security compartment and encrypted with MEK and the service evens are stored in standard Object storage bucket in Logging compartment. 

Service connector is used to ship all the audit, service logs and events in OELZ to these buckets in logging compartment. All IAM Policies for Service Connector are created in the L2 level Home compartment of each environment. 

* **Required Arguments/Parameters for Bucket Retention Policies**:

    1. Prod Environment

    | Name                                                                                                                                                                 | Description                                                                                                                                       | Type     | Default  | Required |
    | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | -------- | :------: |
    | <a name="input_prod_retention_policy_duration_amount"></a> [prod\_retention\_policy\_duration\_amount](#input\_prod\_retention\_policy\_duration\_amount)            | The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp. | `string` | `"1"`    |    no    |
    | <a name="input_prod_retention_policy_duration_time_unit"></a> [prod\_retention\_policy\_duration\_time\_unit](#input\_prod\_retention\_policy\_duration\_time\_unit) | The unit that should be used to interpret timeAmount.                                                                                             | `string` | `"DAYS"` |    no    |

    2. Non-Prod Environment

    | Name                                                                                                                                                                          | Description                                                                                                                                       | Type     | Default  | Required |
    | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | -------- | :------: |
    | <a name="input_nonprod_retention_policy_duration_amount"></a> [nonprod\_retention\_policy\_duration\_amount](#input\_nonprod\_retention\_policy\_duration\_amount)            | The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp. | `string` | `"1"`    |    no    |
    | <a name="input_nonprod_retention_policy_duration_time_unit"></a> [nonprod\_retention\_policy\_duration\_time\_unit](#input\_nonprod\_retention\_policy\_duration\_time\_unit) | The unit that should be used to interpret timeAmount.                                                                                             | `string` | `"DAYS"` |    no    |
    
    3. Archive Log

    | Name                                                                                                                                                                                        | Description                                                                                                                                       | Type     | Default  | Required |
    | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | -------- | :------: |
    | <a name="input_archive_log_retention_policy_duration_amount"></a> [archive\_log\_retention\_policy\_duration\_amount](#input\_archive\_log\_retention\_policy\_duration\_amount)            | The timeAmount is interpreted in units defined by the timeUnit parameter, and is calculated in relation to each object's Last-Modified timestamp. | `string` | `"1"`    |    no    |
    | <a name="input_archive_log_retention_policy_duration_time_unit"></a> [archive\_log\_retention\_policy\_duration\_time\_unit](#input\_archive\_log\_retention\_policy\_duration\_time\_unit) | The unit that should be used to interpret timeAmount.                                                                                             | `string` | `"DAYS"` |    no    |

## Workload Expansion

The variables used for rerun the baseline stack after deploying workload expansion stack.

In Non-Prod:

| Name                                                                                                              | Description                                                                                                   | Type           | Default         | Required |
| ----------------------------------------------------------------------------------------------------------------- |---------------------------------------------------------------------------------------------------------------|----------------| --------------- | :------: |
| <a name="nonprod_additional_workload_subnets_cidr_blocks"></a> [nonprod_additional_workload_subnets_cidr_blocks](#workload\_admin\_group\_name)             | List of 3 subnets CIDR Block used in workload expansion. (Do not include the cidr blocks created in baseline) | `list(string)` |  |    yes    |
| <a name="nonprod_workload_compartment_names"></a> [nonprod_workload_compartment_names](#application\_admin\_group\_name)             | Workload compartment name. (Also include the workload name created in baseline)                               | `list(string)` |  |    yes    |

In Prod:


| Name                                                                                                              | Description                                                                      | Type           | Default         | Required |
| ----------------------------------------------------------------------------------------------------------------- |----------------------------------------------------------------------------------|----------------| --------------- | :------: |
| <a name="prod_additional_workload_subnets_cidr_blocks"></a> [prod_additional_workload_subnets_cidr_blocks](#workload\_admin\_group\_name)       | List of 3 subnets CIDR Block used in workload expansion.(Do not include the cidr blocks created in baseline)                         | `list(string)` |  |    yes    |
| <a name="prod_workload_compartment_names"></a> [prod_workload_compartment_names](#application\_admin\_group\_name)             | Workload compartment name.  (Also include the workload name created in baseline) | `list(string)` |  |    yes    |
