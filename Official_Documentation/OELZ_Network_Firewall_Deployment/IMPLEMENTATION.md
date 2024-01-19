# Oracle Enterprise Landing Zone Network Firewall Feature

# Table of Contents

1. [Introduction](#introduction)
1. [Considerations](#considerations)
1. [Architecture](#architecture)
1. [Deployment Scenarios](#scenarios)
1. [Ways to Deploy](#ways_to_deploy)
1. [Deployment Samples](#samples)


# <a name="introduction"></a>1. Introduction

Oracle Cloud Infrastructure (OCI) Network Firewall is a managed Next-Generation Firewall (NGFW) and Intrusion detection and Prevention service (IDS/IPS) that is powered by Palo Alto Networks®. It is an OCI cloud-native service feature now available in the Oracle Enterprise Landing Zone (OELZ) package. OELZ now offers simple setup and deployment of the OCI Network Firewall service, which gives you visibility into traffic entering your cloud environment (North-South) and traffic between subnets (East-West). This OELZ implementation will deploy a reference Hub and Spoke Network Architecture with a Network Firewall in the Hub.

This repo is under active development. Building open-source software is a community effort. We're excited to engage with the community, and we welcome contributors.


# <a name="considerations"></a>2. Considerations

## 2.1 Access Permissions

Any user who is a member of the OCI Tenancy Administrators can deploy the Oracle Enterprise Landing Zone (OELZ). By default, the OELZ Deployment requires Tenancy administrator privileges to deploy the Network Firewall Feature and privileges to create a compartment in the root compartment. 

## 2.2 Terraform State File

When working with Terraform, a key consideration is how to manage the state of the infrastructure. The local configuration file (tf file) contains the desired state of the infrastructure, and the Terraform state file (terraform.tfstate) contains the actual state of configured resources on OCI Tenancy.

**- Terraform state must be protected against unintentional changes**: <br />
Terraform tfstate file(readable text) `terraform.tfstate` contains the OELZ Network Firewall State. To ensure the accuracy of the OELZ deployment, do not update the state file manually but let Terraform manage the update or use Terraform CLI state management commands if you need to make a manual change. Terraform automatically backs up the state file in *terraform.tfstate.backup* in the same folder as *terraform.tfstate*. Use the Terraform state backup if you cannot recover from a corrupted or lost *terraform.tfstate*.

**- Terraform may overwrite changes made via other means to its managed resources**: <br />
When you provision infrastructure resources with Terraform, the expectation is only Terraform will manage the OCI Tenancy Resources. However, there are situations where quick changes are made outside Terraform, for example, via the OCI Console. If you resume using Terraform later, if some changes are detected, Terraform will overides those manual changes. You can either accept or import those resource changes into the state file. Terraform can import existing resources into the state but does not generate configuration. Therefore, before importing existing resources, it is necessary to add the imported resources into the configuration files manually. This approach is recommended for advanced users only and is out of the scope of this document.


# <a name="architecture"></a>3. Architecture

This reference architecture helps enterprises achieve greater agility, scalability, and security in their cloud environments. One of the key features of Oracle Enterprise Landing Zone v2 is its modular architecture and the ability to implement the OCI Network Firewall natively, which allows enterprises to scale their cloud infrastructure quickly and easily. It also includes best practices for security and compliance, enabling enterprises to maintain a high level of security and meet regulatory requirements. OELZ feature information can be found [here](./Official_Documentation/OELZ_Baseline_Deployment/Architecture_Guide.md).

![NFW Architecture](<../../images/OCI-NFW.jpg> "NFW Architecture")

## 3.1 Hub & Spoke

The Hub & Spoke architecture deployed within the OELZ can provide several benefits, including:

1. Isolation: Each Hub & Spoke has a separate VCN, which provides an additional layer of isolation and security, better management and control over resource access, and limits the blast radius of any security incident.
2. Scalability: As per the Customer requirement, Spoke can be added or removed to support different use cases. Furthermore, this allows for a flexible and scalable architecture that can adapt to changing business needs.
3. Networking: A Hub provides a central point for all network traffic to flow through, simplifying overall Network architecture and improving security using the Network Firewall feature. Resources in different Spokes can communicate with each other over the Hub-Spoke network without having to traverse the internet.
4. Resource Management: Each Spoke can be managed and administered independently for better Resource allocation and efficient use of OCI Resources. It also allows different teams or business units to manage their resources, with the ability to have further access to control and management.
5. Cost Optimization: By centralizing specific resources, like Network Firewall and VPN gateways in the Hub, it can be more cost-effective to manage them.
6. Governance: Having a central Hub makes it much easier to apply governance rules and policies across the whole infrastructure and have a clear view of your enterprise's resources and activity.


In OELZ v2.0 OCI, we create a Hub Network in a Virtual Cloud Network (VCN) in each environment's Network Shared Infrastructure compartment, and the Spoke networks are created in each Workload compartment, using DRG Attachment through a [Dynamic Routing Gateway (DRG)](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingDRGs.htm). Furthermore, this allows the Spoke networks to access the shared resources in the Hub network while maintaining their isolation. As part of the baseline, we are creating one hub and Spoke; additionally, if customers want more Spokes, they can add using the [Workload Expansion Stack](https://github.com/oracle-quickstart/oci-landing-zones/tree/main/templates/elz-workload). In the Hub, OELZ will create two subnets (public and private); in the Spoke VCN, three subnets (web, app, and db) are created. By default, the Network Firewall will deployed on the Hub VCN, and customers can choose whether the Network Firewall should be part of the public or private subnet.


Overall, the Hub & Spoke architecture is a flexible and scalable design pattern that can be used to build complex network architectures in OCI, and this is one of the main reasons why OELZ v2.0 will allow you to have a pre-configured environment ready to use within minutes.

# <a name="scenarios"></a>4. Deployment Scenarios


## 4.1 Greenfield Scenarios

"Greenfield deployment" refers to setting up an OELZ feature with a Network Firewall feature on a clean, new environment with no previous installation or configuration on the OCI Tenancy home region. A Green Field OCI tenancy deployment becomes a matter of provisioning the OELZ resources and adding Network Firewall resources.


## 4.2 Brownfield Scenarios

"Brownfield deployment" refers to deploying a New Firewall Feature on top of the existing OELZ environment on OCI Tenancy. Brownfield deployment gives flexibility to customers, allowing them to install a Network Firewall on top of the OELZ baseline in the future if needed. Additional information on the installation process can be found in section 6.3.

# <a name="ways_to_deploy"></a>5. Ways to Deploy

## 5.1 Deploying with Terraform CLI

Go to folder templates/enterprise-landing-zone, and provide variable values in the existing *example.tfvars* file.

Next, execute:<br />
&nbsp;&nbsp;&nbsp;&nbsp;`terraform init`<br />
&nbsp;&nbsp;&nbsp;&nbsp;`terraform plan -var-file="example.tfvars" -out oelz_nfw.out`<br />
&nbsp;&nbsp;&nbsp;&nbsp;`terraform apply oelz_nfw.out`<br />

### Identity

Terraform CLI executes under the identity information passed to the Terraform provider. In OELZ, the identity is defined in<br />

&nbsp;&nbsp;&nbsp;&nbsp;`tenancy_ocid         = "<tenancy_ocid>"` <br />
&nbsp;&nbsp;&nbsp;&nbsp;`user_ocid            = "<user_ocid>"`<br />
&nbsp;&nbsp;&nbsp;&nbsp;`fingerprint          = "<user_api_key_fingerprint>"`<br />
&nbsp;&nbsp;&nbsp;&nbsp;`private_key_path     = "<path_to_user_private_key_file>"`<br />

The *fingerprint* and private key pair are obtained in OCI Console when an API key is created for the user. Save the private key file locally and provide its path (absolute or relative) to the *private_key_path* variable.


## 5.2 Deploying with OCI Resource Manager UI

There are three different ways to run Terraform code using the OCI Resource Manager (ORM) user interface.<br />
- Creating an ORM stack by uploading a zip file to ORM;<br />
- Uploading the Zip file to ORM(See Section 5.3)<br /> 
- Using RMS OELZ Stack.<br />

A stack is the ORM term for a Terraform configuration and provides an isolated scope for the Terraform state. The stack manages only a single Terraform configuration and, therefore, for addressing multiple OELZ configurations, uses multiple stacks, one for each configuration.<br />

For more ORM information, [please check](https://docs.cloud.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/resourcemanager.htm)

Login to the Tenancy and search "Stack" on the search bar. Click on Create Stack and select the "OELZ v2" template under Architecture Section.

![Create Stack RMS](<../../images/oelz_stack_rms.png> "Create Stack RMS")

Once variable values are provided, click Next, review stack values, and create the stack. <br />
<br />

## 5.3 Stack from Github

Download this repository as a .zip file by expanding the Code button on the repository home page and choosing the "Download ZIP" option.

![OELZ Zip Download](<../../images/oelz_stack_zip.png> "OELZ Zip Download")

Using OCI Console, navigate to Resource Manager service page and create a stack based on a .zip file. <br />
In the **Create Stack** page:<br />

1. Select **My Configuration** option as the origin of the Terraform configuration.<br />
2. In the **Stack Configuration** area, select the **.Zip file** option and upload the .zip file downloaded in the previous step.<br />

![Create Stack](<../../images/oelz_create_stack.png> "Create Stack")

Alternatively, you can click the button below to supply the zip file directly from GitHub without downloading it:
[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/oracle-quickstart/oci-landing-zones/releases/tag/v2.2.0)

*If you are logged in to your OCI tenancy, the button will take you directly to OCI Resource Manager, where you can proceed to deploy. If you are not logged, the button takes you to tje Oracle Cloud initial webpage, where you must enter your tenancy name and log in to OCI.*

Once variable values are provided, click Next, review stack values and create the stack. <br />
<br />
In the Stack page, use the appropriate buttons to plan/apply/destroy your stack.<br />

# <a name="samples"></a>6. Deployment Samples

This section provides two deployment scenarios of the OELZ Network Firewall Feature. By Design, we had turned off the Network Firewall feature in both Production and Non-Production environments. The Network Firewall can be enabled in either of the environments, but not simultaneously in both environments. By default the Network Firewall Policy is to `reject all traffic`.

## 6.1 : Network Firewall Feature Varibles

| Variable Name      | Description| Type | Default
| ------------------- | ----- | ----- | ----- |
| <a name="enable_network_firewall_prod"></a> [enable\_network\_firewall\_prod](#enable\_network\_firewall\_prod)   | Enable Network Firewall Resource in Production Environment | `boolean` | `"false"`    | 
| <a name="enable_traffic_threat_log_prod"></a> [enable\_traffic\_threat\_log\_prod](#enable\_traffic\_threat\_log\_prod) | Enable Network Firewall Threat and Traffic Log in Production Environment. | `boolean` | `"false"`    | 
| <a name="nfw_subnet_type_prod"></a> [nfw\_subnet\_type\_prod](#nfw\_subnet\_type\_prod])           | Enable Network Firewall in Production Hub VCN Public or Private Subnet.   | `string` | `"public"`    | 
| <a name="nfw_instance_name_prod"></a> [nfw\_instance\_name\_prod](#nfw\_instance\_name\_prod)         | Network Firewall Resource Name.                                           | `string` | `"OCI-ELZ-NFW-P"`    | 
| <a name="nfw_instance_policy_prod"></a> [nfw\_instance\_policy\_prod](#nfw\_instance\_policy\_prod)        | Network Firewall Policy Name.                                           | `string` | `"OCI-ELZ-NFW-<TRAFFIC|THREAT>-LOG-P"`    | 
| <a name="enable_network_firewall_nonprod"></a> [enable\_network\_firewall\_nonprod](#enable\_network\_firewall\_nonprod)   | Enable Network Firewall Resource in Non-Production Environment | `boolean` | `"false"`    | 
| <a name="enable_traffic_threat_log_nonprod"></a> [enable\_traffic\_threat\_log\_nonprod](#enable\_traffic\_threat\_log\_nonprod) | Enable Network Firewall Threat and Traffic Log in Non-Production Environment. | `boolean` | `"false"`    | 
| <a name="nfw_subnet_type_nonprod"></a> [nfw\_subnet\_type\_nonprod](#nfw\_subnet\_type\_nonprod])           | Enable Network Firewall in Non-Production Hub VCN Public or Private Subnet.   | `string` | `"public"`    | 
| <a name="nfw_instance_name_nonprod"></a> [nfw\_instance\_name\_nonprod](#nfw\_instance\_name\_nonprod)         | Network Firewall Resource Name.                                           | `string` | `"OCI-ELZ-NFW-N"`    | 
| <a name="nfw_instance_policy_nonprod"></a> [nfw\_instance\_policy\_nonprod](#nfw\_instance\_policy\_nonprod)        | Network Firewall Policy Name.                                           | `string` | `"OCI-ELZ-NFW-<TRAFFIC|THREAT>-LOG-N"`    | 

## Sample tfvars : To Enable Network Firewall (private Hub subnet) on Production Enviornment

  &nbsp;&nbsp;&nbsp;&nbsp;`enable_network_firewall_prod   = "true"` <br />
  &nbsp;&nbsp;&nbsp;&nbsp;`enable_traffic_threat_log_prod = "true"`  <br />
  &nbsp;&nbsp;&nbsp;&nbsp;`nfw_subnet_type_prod           = "private"` <br />
  &nbsp;&nbsp;&nbsp;&nbsp;`nfw_instance_name_prod         = "nfw_name"` <br />
  &nbsp;&nbsp;&nbsp;&nbsp;`nfw_instance_policy_prod       = "nfw_name_policy"` <br />


## Sample tfvars : To Enable Network Firewall (public Hub subnet) on Non-Production Enviornment

  &nbsp;&nbsp;&nbsp;&nbsp;`enable_network_firewall_nonprod   = "true"` <br />
  &nbsp;&nbsp;&nbsp;&nbsp;`enable_traffic_threat_log_nonprod = "false"` <br />
  &nbsp;&nbsp;&nbsp;&nbsp;`nfw_subnet_type_nonprod           = "public"` <br />
  &nbsp;&nbsp;&nbsp;&nbsp;`nfw_instance_name_nonprod         = "nfw_name"` <br />
  &nbsp;&nbsp;&nbsp;&nbsp;`nfw_instance_policy_nonprod       = "nfw_name_policy"` <br />

## 6.2 Greenfield Deployment : Network Firewall Part of Baseline Deployment.


* Step 1) Go to folder templates/enterprise-landing-zone.
* Step 2) Provide variable values in the existing *example.tfvars* file. Add the following Network Firewall Related Variables on *example.tfvars* file.<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`enable_network_firewall_prod   = "true"` <br />
  &nbsp;&nbsp;&nbsp;&nbsp;`enable_traffic_threat_log_prod = "true"`  <br />
  &nbsp;&nbsp;&nbsp;&nbsp;`nfw_subnet_type_prod           = "private"` <br />
  &nbsp;&nbsp;&nbsp;&nbsp;`nfw_instance_name_prod         = "nfw_name"` <br />
  &nbsp;&nbsp;&nbsp;&nbsp;`nfw_instance_policy_prod       = "nfw_name_policy"` <br />
* Step 3) Use any deployment scenario in Section 5. We are using the terraform CLI (Section 5.1) method.
* Step 4) Execute the Following.<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`terraform init`<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`terraform plan -var-file="example.tfvars" -out oelz_nfw.out`<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`terraform apply oelz_nfw.out`<br />
* Step 5) Network Firewall Provisioning usually take 45-50 minutes.
* Step 6) Deploy one more Spoke using Workload Expansion.
    * Step 6.1) Go to folder templates/elz-workload.
    * Step 6.2) Provide variable values in the existing *workload_extension-variables.tfvars* file.
    * Step 6.3) Workload Extension Variable Sample.<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`enable_compartment_delete             = false`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`workload_compartment_name             = <"Workload Compartment Name">`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`environment_compartment_id            = < Environment OCID where network firewall is deployed >`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`workload_expansion_flag               = true`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`environment_prefix                    = "< Production or Non-Production Environment >"`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`workload_prefix                       = "WRKTEST01"`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`identity_domain_id                    = < Identity Domain OCID Where Network Firewall Deployed >`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`identity_domain_name                  = < Identity Domain Name Where Network Firewall Deployed >`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`security_compartment_name             = < Security Compartment Name >`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`security_compartment_id               = < Security Compartment ID >`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`workload_admin_group_name             = "TEST-WRK1-ADMIN"`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`application_admin_group_name          = "TEST-WRK1-ADMIN-APP"`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`database_admin_group_name             = "TEST-WRK1-ADMIN-DB"`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`idcs_endpoint                         = < Identity Domain IDCS Endpoint >`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`security_admin_group_name             = "OCI-ELZ-UGP-P-SEC-ADMIN"`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`network_admin_group_name              = "OCI-ELZ-UGP-P-NET-ADMIN"`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`workload_spoke_vcn_cidr                          = "10.5.0.0/16"`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`workload_private_spoke_subnet_web_cidr_block     = "10.5.1.0/24"`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`workload_private_spoke_subnet_app_cidr_block     = "10.5.2.0/24"`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`workload_private_spoke_subnet_db_cidr_block      = "10.5.3.0/24"`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`enable_nat_gateway_spoke                         = true`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`enable_service_gateway_spoke                     = true`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`drg_id                                           = < DRG OCID Value >`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`hub_public_subnet_cidr_block                     = "10.1.1.0/24"`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`hub_private_subnet_cidr_block                    = "10.1.2.0/24"`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`workload_name            = "WSPK1"`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`enable_network_monitoring_alarms  = false`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`enable_security_monitoring_alarms = false`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`enable_workload_monitoring_alarms = false`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`# workload_topic_endpoints = [""]`<br />
    * Step 6.4) Take a backup of providers.tf file.
    * Step 6.5) Copy providers.standalone file content to providers.tf file.
    * Step 6.6) Execute the Following.<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`terraform init`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`terraform plan -var-file="workload_extension-variables.tfvars" -out oelz_wrkspoke1.out`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`terraform apply oelz_wrkspoke1.out`<br />
    * Step 6.7) Add the Baseline Spoke Route on the Newly Created Spoke Route Table. Update the following variable on *workload_extension-variables.tfvars* file.<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`workload_topic_endpoints = ["< SPOKE CIDR BLOCK>"]`<br />
    * Step 6.8) Execute the Following. (This step will revert the Wrk Spoke VCN Security List to default i.e., Manually added Wrk Spoke VCN Security rules will be deleted)<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`terraform plan -var-file="workload_extension-variables.tfvars" -out oelz_nfw_spoke_route.out`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`terraform apply oelz_nfw_spoke_route.out`<br />
    * Step 6.9) Merge backup of providers.tf file to provider.tf file.
    * Step 6.10) Go to Folder templates/enterprise-landing-zone.
    * Step 6.11) Add the newly created Spoke Routes on the Existing Hub and Spoke Route Table. Update the following variable on *example.tfvars* file.<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`prod_workload_compartment_names                 = [ < New Workload Compartment Name > ]`
    &nbsp;&nbsp;&nbsp;&nbsp;`prod_additional_workload_subnets_cidr_blocks    = [ < New Spoke VCN CIDR > ]`
    * Step 6.12) Execute the Following. (This step will revert the Network Firewall Policy, Hub and Spoke VCN Security List to default i.e., Manually added Network Firewall Policy and Hub Spoke VCN Security Rules will be deleted).<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`terraform plan -var-file="workload_extension-variabes"`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`terraform plan -var-file="example.tfvars" -out oelz_nfw_wrkspoke_route.out`<br />
    &nbsp;&nbsp;&nbsp;&nbsp;`terraform apply oelz_nfw_wrkspoke_route.out`<br />


## 6.3 Brownfield Deployment: Add Network Firewall on top of Existing Baseline OELZ.

* Step 1) Go to folder templates/enterprise-landing-zone.
* Step 2) Provide OELZ Baseline variable values in the existing *example.tfvars* file. Do not add any Network Firewall Related Variables on the *example.tfvars* file.
* Step 3) Execute the Following.<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`terraform init`<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`terraform plan -var-file="example.tfvars" -out oelz_baseline.out`<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`terraform apply oelz_baseline.out`<br />
* Step 4) Update the Network Firewall variables on existing *example.tfvars* file .<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`enable_network_firewall_prod   = "true"` <br />
  &nbsp;&nbsp;&nbsp;&nbsp;`enable_traffic_threat_log_prod = "true"`  <br />
  &nbsp;&nbsp;&nbsp;&nbsp;`nfw_subnet_type_prod           = "private"` <br />
  &nbsp;&nbsp;&nbsp;&nbsp;`nfw_instance_name_prod         = "nfw_name"` <br />
  &nbsp;&nbsp;&nbsp;&nbsp;`nfw_instance_policy_prod       = "nfw_name_policy"` <br />
* Step 3) Execute the Following.<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`terraform plan -var-file="example.tfvars" -out oelz_nfwonbaseline.out`<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`terraform apply oelz_nfwonbaseline.out`<br />
* Step 4) Follow the Same Step 6 defined on Greenfield Deployment if you want to deploy more Workload Spoke.<br />

# License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](../../LICENSE) for more details.
