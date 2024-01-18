# Oracle Enterprise Landing Zone Disaster Recovery(DR)/ Multi Region(MR)

# Table of Contents

1. [Introduction](#introduction)
1. [Disaster Recovery](#considerations)
1. [Multi Region](#architecture)
1. [Deployment Samples](#samples)


# <a name="introduction"></a>1. Introduction

A disaster can be any event that puts your applications and valuable data at risk, from network outages to equipment failures to natural disasters. A well-architected disaster recovery plan enables you to recover quickly from disasters and continue to provide services to your organization and customers.

Oracle Cloud Infrastructure (OCI) provides highly available, secure, and scalable infrastructure and services that enable you to recover your cloud workloads quickly, reliably, and securely. While there is considerable resiliency built into the design of each region, a natural disaster can potentially cause an entire OCI region to become unavailable. This scenario is one of the most severe cases in your disaster recovery planning and design. To protect against this scenario, it is prudent to deploy your critical business workloads across multiple OCI regions. You can backup or replicate your data to another region depending on your disaster recovery goals, depending on your Business Continuity Plan's (BCP) recovery time ojective (RTO) or recovery point objectives (RPO).

This repo is under active development. Building open-source software is a community effort. We're excited to engage with the community, and we welcome contributors.


# <a name="Disaster Recovery"></a>2. Disaster Recovery

## 2.1 Introduction

A disaster recovery (DR) plan enables you to recover quickly from disasters and continue to provide services to your users.

DR is the process of preparing for and recovering from a disaster. A disaster can be any event that puts your applications at risk, from network outages to equipment and application failures to natural disasters. It's almost impossible to predict when you will need disaster recovery, just like you can't predict when you'll get in a car accident. If you can't control when a disaster strikes, the next best thing is to be able to manage the recovery process and bring the services back online within your defined RPO and RTO. 

## 2.2 Design Consideration

The module will allow the customer to deploy an additional OELZ infrastructure to the existing OELZ v2 in another region.

The Disaster Recovery feature will deploy identical resources using the Disaster Recovery Warm stand-by approach.  It is up to the customer to manage their workload DR strategy but OELZ will provide the necessary infrastructure services to support either a warm or active-active DR solution.

# <a name="Multi Region"></a>3. Multi Region

## 3.1 Introduction

Multi-Region Replication replicates the OELZ resources on the designated paired backup region. This feature supports the paired backup regions where all identity resources are by default replicated to their designated paired backup regions and other OELZ resources will be replicated by new code. Please refer to official OCI documentation to determine whether your region is configured for identity services replication.


## 3.2 Design Consideration

* Paired Region use case.
* Multi Region warm back-up solution.
* OELZ DRMR Module replicates the OELZ Resources on Backup Region, its customer job to configure the OELZ environment to support their DR objectives as this Landing Zone does not create any compute instances or workloads.


# <a name="Deployment Samples"></a>Deployment Samples

## 4.1 : DR and MR Related New Variables on Baseline TFVAR File.


| Variable Name      | Description| Type | Default
| ------------------- | ----- | ----- | ----- |
| <a name="enable_landing_zone_replication"></a> [enable\_landing\_zone\_replication](#enable\_network\_firewall\_prod)   | Enable Multi Region  Replication in Both Environment | `boolean` | `"false"`    | 
| <a name="backup_region"></a> [backup\_region](#enable\_network\_firewall\_prod)   | Enter Paried Backup Region Name | `string` | `"<>"`    | 

## 4.2 : DR and MR Related New Variables on ELZ-BACKUP Directory

Go to Folder templates/elz-backup/elz-backup-environment/Single_Dr_Deployment.tfvars

| Variable Name      | Description| Type | Default
| ------------------- | ----- | ----- | ----- |
| <a name="home_compartment_name"></a> [home\_compartment\_name](#home\_compartment\_name)   | Provide Home Compartment Name | `string` | `<comp_name>`    | 
| <a name="home_compartment_id"></a> [home\_compartment\_id](#home\_compartment\_id)   | Provide Home Compartment OCID Value | `string` | `"<ocid.*>"`    |
| <a name="environment_compartment_id"></a> [environment\_compartment\_id](#environment\_compartment\_id])   | Provide Environment Compartment OCID Value | `string` | `"<ocid.*>"`    | 
| <a name="security_compartment_id"></a> [security\_compartment\_id](#security\_compartment\_id)   | Provide Security Compartment OCID Value | `string` | `"<ocid.*>"`    | 
| <a name="network_compartment_id"></a> [network\_compartment\_id](#network\_compartment\_id)   | Provide Network Compartment OCID Value | `string` | `"<ocid.*>"`    | 
| <a name="workload_compartment_id"></a> [workload\_compartment\_id](#workload\_compartment\_id)   | Provide Workload Compartment OCID Value | `string` | `"<ocid.*>"`    | 
| <a name="logging_compartment_id"></a> [logging\_compartment\_id](#logging_compartment_id)   | Provide Logging Compartment OCID Value | `string` | `"<ocid.*>"`    |

Note : In OELZ, we have two distinct environments: Production and Non-Production. To deploy the Production Environment, please provide the associated OCID value. In the case of Non-Prod, using the Non-Prod associated OCID value. If customers have multiple workloads, you must deploy the workload expansion stack to add additional workload compartments one at a time.


## 4.3 : DR and MR Feature Deployment.

* Step 1) Go to Folder templates/elz-backup/elz-backup-environment.
* Step 2) Provide variable values in the existing *Single_DR_Deployment.tfvars* file defined in section 4.2.
* Step 3) Provide the network, monitoring, identity, and security module-related variables in the tfvars file. 
* Step 4) Execute the following Terraform from the CLI.
  &nbsp;&nbsp;&nbsp;&nbsp;`terraform init`<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`terraform plan -var-file="Single_DR_Deployment.tfvars" -out oelz_dr_mr.out`<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`terraform apply oelz_dr_mr.out`<br />
* Step 5) Provisioning usually take 45-50 minutes depending on services selected.


# License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](../../LICENSE) for more details.