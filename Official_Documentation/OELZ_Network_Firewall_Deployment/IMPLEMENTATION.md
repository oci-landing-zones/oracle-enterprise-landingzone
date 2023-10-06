# Oracle Enterprise Landing Zone Network Firewall Feature

# Table of Contents

1. [Introduction](#introduction)
1. [Considerations](#considerations)
1. [Architecture](#architecture)
1. [Deployment Scenarios](#scenarios)
1. [Ways to Deploy](#ways_to_deploy)
1. [Deployment Samples](#samples)


# <a name="introduction"></a>1. Introduction

Oracle Cloud Infrastructure Network Firewall is a managed next-generation network firewall and intrusion detection and prevention service for Oracle Cloud Infrastructure VCN, powered by Palo Alto Networks®. Network Firewall feature as part Oracle Enterprise Landing Zone(OELZ) environment offers simple setup and deployment and gives you visibility into traffic entering your cloud environment (North to South) as well traffic between subnets (East to West). This reference OELZ implementation will deploy Hub and Spoke Network Architecture with Network Firewall on Hub.

This repo is under active development. Building open source software is a community effort. We're excited to engage with the community building this.

# <a name="considerations"></a>2. Considerations

## 2.1 Access Permissions

The Oracle Enterprise Landing Zone(OELZ) is desgined to be deployed by tenancy administrator (any user that part of Administrator group). By Default, OELZ require tenancy amninstrator permissions in the tenancy to deploy Network Firewall, Network Firewall Policy and creation of compartment in the root compartment. 

## 2.2 Green Field and Brown Field Deployments


## 2.3 Terraform State File

When working with Terraform , as key considersation is how to manage the state of infrastructure. The desired state of the instrastructure is expressed in the local confgiuration file(tf file) and acatual state of the infrastructure is stored in the Terraform state file (terraform.tfstate).

**- Terraform state must be protected against unintentional changes**: OELZ Network Firewall State will be stored in terraform.tfstate file(readable text). To ensure the accuracy of the OELZ deployes , do not update the state file manually. Let terraform manage it or use Terraform CLI state management commands if you need to make a manual change . Terraform automatically backs up the state file in *terraform.tfstate.backup* in the same folder as *terraform.tfstate*. Use that in case you cannot recover from a corrupted or lost *terraform.tfstate*.

**- Terraform may overwrite changes made via other means to its managed resources**: when you provision infrastructure resources with Terraform, it is expected that those resources are going to be managed via Terraform. However, there are situations where quick changes are made outside Terraform, like via the OCI Console. If you resume using Terraform later, those changes will be detected and Terraform will inform you that those changes will be overwritten. You can either accept that or import those resource changes into the state file. Terraform can import existing resources into the state, but it does not generate configuration. Therefore, before importing existing resources, it is necessary to manually add the imported resources into the configuration files. This approach is recommended for advanced users only and is out of the scope of this document.


# <a name="architecture"></a>3. Architecture

This reference architecture helps enterprises achieve greater agility, scalability, and security in their cloud environments.
One of the key features of Oracle Enterprise Landing Zone v2 is its modular architecture and the ability to implement the OCI Network Firewall natively, which allows enterprises to scale their cloud infrastructure quickly and easily. It also includes best practices for security and compliance, enabling enterprises to maintain a high level of security and meet regulatory requirements. OELZ feature information can be found 
[here](https://github.com/oracle-quickstart/oci-landing-zones/blob/main/templates/enterprise-landing-zone/Architecture_Guide.md).

![NFW Architecture](<../../images/OCI-NFW.jpg> "NFW Architecture")

## 3.1 Hub & Spoke


# <a name="scenarios"></a>4. Deployment Scenarios


## 4.1 Greenfield Scenarios

The OELZ with Network Firewall Feature can be deployed in any new OCI tenancies (Green Field use-case). For a Green Field OCI tenancy deploying becomes a matter of provisioning the OELZ and then adding any other resources on top of it. This is the simplest deployment scenario. As part of Baseline we deploy one Hub and Spoke and Network can be deployed on Hub Public or Private Subnet. If customer need more Spoke , they deploy Workload Expansion template.


## 4.2 Brownfield Scenarios

In Brown Field we deploy the Network Firewall Feature in top of the existing OELZ and alongside the existing workload(s) and use the OELZ workload template for new workloads spoke vcn.

# <a name="ways_to_deploy"></a>5. Ways to Deploy

## 5.1 Deploying with Terraform CLI

Go to folder templates/enterprise-landing-zone, provide variable values in the existing *example.tfvars* file.

Next, execute:<br />
    `terraform init`<br />
    `terraform plan -var-file="example.tfvars" -out oelz_nfw.out`<br />
    `terraform apply oelz_nfw.out`<br />

### Identity

Terraform CLI executes under the identity information passed to Terraform provider. In OELZ, the identity is defined in
    `tenancy_ocid         = "<tenancy_ocid>"` <br />
    `user_ocid            = "<user_ocid>"`<br />
    `fingerprint          = "<user_api_key_fingerprint>"`<br />
    `private_key_path     = "<path_to_user_private_key_file>"`<br />

The *fingerprint* and private key pair are obtained in OCI Console when an API key is created for the user. Save the private key file locally and provide its path (absolute or relative) to the *private_key_path* variable.


## 5.2 Deploying with OCI Resource Manager UI

There are a two different ways to run Terraform code using OCI Resource Manager (ORM) user interface. Here we describe two of them: <br />
- creating an ORM stack by uploading a zip file to ORM;<br />
- Uploading the Zip File to ORM<br />
- Using RMS OELZ Stack.<br />

A stack is the ORM term for a Terraform configuration and provide an isolated scope for Terraform state. A Stack manages one and only Terraform configuration. Therefore, for managing multiple Landing Zone configurations, use multiple stacks, one for each configuration.<br />


For more ORM information, [please check](https://docs.cloud.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/resourcemanager.htm)

## 5.3 Stack from Github

Download this repository as a .zip file, by expanding the Code button in the repository home page and choosing the "Download ZIP" option.

![OELZ Zip Download](<../../images/oelz_stack_zip.png> "OELZ Zip Download")

Using OCI Console, navigate to Resource Manager service page and create a stack based on a .zip file. <br />
In the **Create Stack** page:<br />

1. Select **My Configuration** option as the origin of the Terraform configuration.<br />
2. In the **Stack Configuration** area, select the **.Zip file** option and upload the .zip file downloaded in the previous step.<br />

![Create Stack](<../../images/oelz_create_stack.png> "Create Stack")

Alternatively, you can simply click the button below to supply the zip file directly from GitHub without downloading it:
[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/oracle-quickstart/oci-landing-zones/archive/refs/tags/v3.0.0.zip)

*If you are logged in your OCI tenancy, the button will take you directly to OCI Resource Manager where you can proceed to deploy. If you are not logged, the button takes you to Oracle Cloud initial page where you must enter your tenancy name and log in to OCI.*

Once variable values are provided, click Next, review stack values and create the stack. <br />
<br />
In the Stack page use the appropriate buttons to plan/apply/destroy your stack.<br />

# <a name="samples"></a>7. Deployment Samples

In this section we provide two deployment sceanrio of OELZ network firewall feature. By Design, Network Firewall will be disable in both Production and Non-Production Enivornment and can be enabled on one Enivornment either Prodution or Non-Production. By default the Network Firewall Policy is reject all traffic.

## 6.1 : Network Firewall Feature Varibles

| Variable Name      | Description| Type | Default
| ------------------- | ----- | ----- | ----- |
| <a name="enable_network_firewall_prod"></a> [enable\_network\_firewall\_prod](#enable\_network\_firewall\_prod)   | Enable Network Firewall Resource in Production Environment | `boolean` | `"false"`    | 
| <a name="enable_traffic_threat_log_prod"></a> [enable\_traffic\_threat\_log\_prod](#enable\_traffic\_threat\_log\_prod) | Enable Network Firewall Threat and Traffic Log in Production Environment. | `boolean` | `"false"`    | 
| <a name="nfw_subnet_type_prod"></a> [nfw\_subnet\_type\_prod](#nfw\_subnet\_type\_prod])           | Enable Network Firewall in Production Hub VCN Public or Private Subnet.   | `string` | `"public"`    | 
| <a name="nfw_instance_name_prod"></a> [nfw\_instance\_name\_prod](#nfw\_instance\_name\_prod)         | Network Firewall Resource Name.                                           | `string` | `"OCI-ELZ-NFW-P"`    | 
| <a name="nfw_instance_policy_prod"></a> [nfw\_instance\_policy\_prod](#nfw\_instance\_policy\_prod)        | Network Firewall Policy Name.                                           | `string` | `"OCI-ELZ-NFW-<TRAFFIC|THREAT>-LOG-P"`    | 
| <a name="enable_network_firewall_nonprod"></a> [enable\_network\_firewall\_nonprod](#enable\_network\_firewall\_nonprod)   | Enable Network Firewall Resource in Production Environment | `boolean` | `"false"`    | 
| <a name="enable_traffic_threat_log_nonprod"></a> [enable\_traffic\_threat\_log\_nonprod](#enable\_traffic\_threat\_log\_nonprod) | Enable Network Firewall Threat and Traffic Log in Production Environment. | `boolean` | `"false"`    | 
| <a name="nfw_subnet_type_nonprod"></a> [nfw\_subnet\_type\_nonprod](#nfw\_subnet\_type\_nonprod])           | Enable Network Firewall in Production Hub VCN Public or Private Subnet.   | `string` | `"public"`    | 
| <a name="nfw_instance_name_nonprod"></a> [nfw\_instance\_name\_nonprod](#nfw\_instance\_name\_nonprod)         | Network Firewall Resource Name.                                           | `string` | `"OCI-ELZ-NFW-N"`    | 
| <a name="nfw_instance_policy_nonprod"></a> [nfw\_instance\_policy\_nonprod](#nfw\_instance\_policy\_nonprod)        | Network Firewall Policy Name.                                           | `string` | `"OCI-ELZ-NFW-<TRAFFIC|THREAT>-LOG-N"`    | 

## Sample tfvars : To Enable Network Firewall (private hub subnet) on Production Enviornment

  `enable_network_firewall_prod   = "true"` <br />
  `enable_traffic_threat_log_prod = "true"`  <br />
  `nfw_subnet_type_prod           = "private"` <br />
  `nfw_instance_name_prod         = "nfw_name"` <br />
  `nfw_instance_policy_prod       = "nfw_name_policy"` <br />


## Sample tfvars : To Enable Network Firewall (public hub subnet) on Non-Production Enviornment

  `enable_network_firewall_nonprod   = "true"` <br />
  `enable_traffic_threat_log_nonprod = "false"` <br />
  `nfw_subnet_type_nonprod           = "public"` <br />
  `nfw_instance_name_nonprod         = "nfw_name"` <br />
  `nfw_instance_policy_nonprod       = "nfw_name_policy"` <br />

## 6.2 Greenfield Deployment : Network Firewall Part of Baseline Deployment.


* Step 1) Go to folder templates/enterprise-landing-zone.
* Step 2) Provide variable values in the existing *example.tfvars* file. Add the following Network Firewall Related Variables on *example.tfvars* file.
        `enable_network_firewall_prod   = "true"` <br />
        `enable_traffic_threat_log_prod = "true"`  <br />
        `nfw_subnet_type_prod           = "private"` <br />
        `nfw_instance_name_prod         = "nfw_name"` <br />
        `nfw_instance_policy_prod       = "nfw_name_policy"` <br />
* Step 3) Use any deployment scenario in Section 5. We are using the terraform CLI (Section 5.1) method.
* Step 4) Execute the Following.<br />
    `terraform init`<br />
    `terraform plan -var-file="example.tfvars" -out oelz_nfw.out`<br />
    `terraform apply oelz_nfw.out`<br />
* Step 5) Network Firewall Provisioning ususlly take 45-50 minutes.
* Step 6) Deploy one more spoke using Workload Expansion.
    * Step 6.1) Go to folder templates/elz-workload.
    * Step 6.2) Provide variable values in the existing *workload_extension-variables.tfvars* file
    * Step 6.3) Workload Extension Variable Sample

          `enable_compartment_delete             = false`<br />
          `workload_compartment_name             = <"Workload Compartment Name">`<br />
          `environment_compartment_id            = < Environment OCID where network firewall is deployed >`<br />
          `workload_expansion_flag               = true`<br />
          `environment_prefix                    = "< Production or Non-Production Environment >"`<br />
          `workload_prefix                       = "WRKTEST01"`<br />
          `identity_domain_id                    = < Identity Domain OCID Where Network Firewall Deployed >`<br />
          `identity_domain_name                  = < Identity Domain Name Where Network Firewall Deployed >`<br />
          `security_compartment_name             = < Security Compartment Name >`<br />
          `security_compartment_id               = < Security Compartment ID >`<br />
          `workload_admin_group_name             = "TEST-WRK1-ADMIN"`<br />
          `application_admin_group_name          = "TEST-WRK1-ADMIN-APP"`<br />
          `database_admin_group_name             = "TEST-WRK1-ADMIN-DB"`<br />
          `idcs_endpoint                         = < Identity Domain IDCS Endpoint >`<br />
          `security_admin_group_name             = "OCI-ELZ-UGP-P-SEC-ADMIN"`<br />
          `network_admin_group_name              = "OCI-ELZ-UGP-P-NET-ADMIN"`<br />
          `workload_spoke_vcn_cidr                          = "10.5.0.0/16"`<br />
          `workload_private_spoke_subnet_web_cidr_block     = "10.5.1.0/24"`<br />
          `workload_private_spoke_subnet_app_cidr_block     = "10.5.2.0/24"`<br />
          `workload_private_spoke_subnet_db_cidr_block      = "10.5.3.0/24"`<br />
          `enable_nat_gateway_spoke                         = true`<br />
          `enable_service_gateway_spoke                     = true`<br />
          `drg_id                                           = < DRG OCID Value >`<br />
          `hub_public_subnet_cidr_block                     = "10.1.1.0/24"`<br />
          `hub_private_subnet_cidr_block                    = "10.1.2.0/24"`<br />
          `workload_name            = "WSPK1"`<br />
          `enable_network_monitoring_alarms  = false`<br />
          `enable_security_monitoring_alarms = false`<br />
          `enable_workload_monitoring_alarms = false`<br />
          `# workload_topic_endpoints = [""]`<br />

    * Step 6.4) Take a backup of providers.tf file.
    * Step 6.5) Copy providers.standalone file content to providers.tf file.
    * Step 6.6) Execute the Following.<br />
            `terraform init`<br />
            `terraform plan -var-file="workload_extension-variables.tfvars" -out oelz_wrkspoke1.out`<br />
            `terraform apply oelz_wrkspoke1.out`<br />
    * Step 6.7) Add the Baseline Spoke Route on the Newly Created Spoke Route Table. Update the following variable on *workload_extension-variables.tfvars* file.
            `workload_topic_endpoints = ["< SPOKE CIDR BLOCK>"]`<br />
    * Step 6.8) Execute the Following.<br />
        `terraform plan -var-file="workload_extension-variables.tfvars" -out oelz_nfw_spoke_route.out`<br />
        `terraform apply oelz_nfw_spoke_route.out`<br />
    * Step 6.9) Maerge backup of providers.tf file to provider.tf file.
    * Step 6.10) Go to Folder templates/enterprise-landing-zone.
    * Step 6.11) Add the newly created Spoke Routes on the Existing Hub and Spoke Route Table. Update the following variable on *example.tfvars* file.
        prod_workload_compartment_names                 = [ < New Workload Compartment Name > ]
        prod_additional_workload_subnets_cidr_blocks    = [ < New Spoke VCN CIDR > ]
    * Step 6.12) Execute the Following.<br />
        `terraform plan -var-file="example.tfvars" -out oelz_nfw_wrkspoke_route.out`<br />
        `terraform apply oelz_nfw_wrkspoke_route.out`<br />


## 7.1 Brownfield Deployment : Add Network Firewall on top of Existing Baseline OELZ.

* Step 1) Go to folder templates/enterprise-landing-zone.
* Step 2) Provide variable values in the existing *example.tfvars* file. Do not add any  Network Firewall Related Variables on *example.tfvars* file.
* Step 3) Execute the Following.<br />
    `terraform init`<br />
    `terraform plan -var-file="example.tfvars" -out oelz_baseline.out`<br />
    `terraform apply oelz_baseline.out`<br />
* Step 4) Update the Network Firewall variables on existing *example.tfvars* file .
        `enable_network_firewall_prod   = "true"` <br />
        `enable_traffic_threat_log_prod = "true"`  <br />
        `nfw_subnet_type_prod           = "private"` <br />
        `nfw_instance_name_prod         = "nfw_name"` <br />
        `nfw_instance_policy_prod       = "nfw_name_policy"` <br />
* Step 3) Execute the Following.<br />
    `terraform plan -var-file="example.tfvars" -out oelz_nfwonbaseline.out`<br />
    `terraform apply oelz_nfwonbaseline.out`<br />
* Step 4) Follow the Same Step 6 defined on Green Field Deployment.
