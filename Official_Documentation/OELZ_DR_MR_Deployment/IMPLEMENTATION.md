# Oracle Enterprise Landing Zone Disaster Recovery(DR)/ Multi Region(MR)

# Table of Contents

1. [Introduction](#introduction)
1. [Disaster Recovery](#considerations)
1. [Multi Region](#architecture)
1. [Deployment Samples](#samples)


# <a name="introduction"></a>1. Introduction

A disaster can be any event that puts your applications at risk, from network outages to equipment failures to natural disasters. A well-architected disaster recovery plan enables you to recover quickly from disasters and continue to provide services to your users.

Oracle Cloud Infrastructure (OCI) provides highly available, secure, and scalable infrastructure and services that enable you to recover your cloud workloads quickly, reliably, and securely. A natural disaster can cause an entire OCI region to be out of service. This scenario is one of the most severe cases in your disaster recovery design. To protect against this scenario, deploy your workloads across multiple OCI regions. You can back up or replicate your data to another region depending on your disaster recovery goals, whether recovery time or point objectives (RTO and RPO).

This repo is under active development. Building open-source software is a community effort. We're excited to engage with the community, and we welcome contributors.


# <a name="Disaster Recovery"></a>2. Disaster Recovery

## 2.1 Introduction

A disaster recovery (DR) plan enables you to recover quickly from disasters and continue to provide services to your users.

DR is the process of preparing for and recovering from a disaster. A disaster can be any event that puts your applications at risk, from network outages to equipment and application failures to natural disasters. It's almost impossible to predict when you will need disaster recovery, just like you can't predict when you'll get in a car accident. If you can't control when a disaster strikes, the next best thing is to be able to control the recovery process. 

## 2.2 Design Consideration

The module will allow the customer to deploy an additional OELZ infrastructure to the existing OELZ v2 in another region.

The Disaster Recovery Feature will deploy identical resources using the Disaster Recovery Warm stand-by Approach.

# <a name="Multi Region"></a>3. Multi Region

## 3.1 Introduction

Multi-Region Replication replicates the OELZ resources on the paired backup region. By default, we are only supporting the paired backup regions where all identity resources are by default replicated to paired backup regions and other OELZ resources will be replicated by new code. 


## 3.2 Design Consideration

* Paired Region Use case Only.
* MR Warm Back-up Solution.
* OELZ DRMR Module replicates the OELZ Resources on Backup Region, its customer job to or MR Policies as Module is not creating any storage object or compute instance.


# <a name="Deployment Samples"></a>Deployment Samples

## 4.1 : DR and MR Related New Variables on Baseline TFVAR File.


| Variable Name      | Description| Type | Default
| ------------------- | ----- | ----- | ----- |
| <a name="enable_landing_zone_replication"></a> [enable\_landing\_zone\_replication](#enable\_network\_firewall\_prod)   | Enable Multi Region  Replication in Both Environment | `boolean` | `"false"`    | 
| <a name="backup_region"></a> [backup\_region](#enable\_network\_firewall\_prod)   | Enter Paried Backup Region Name | `string` | `"<>"`    | 

## 4.2 : DR and MR Related New Variables on ELZ-BACKUP TFVAR File.

Go to Folder templates/elz-backup/elz-backup-environment/

| Variable Name      | Description| Type | Default
| ------------------- | ----- | ----- | ----- |
| <a name="home_compartment_name"></a> [home\_compartment\_name](#home\_compartment\_name)   | Provide Home Compartment Name | `string` | `<comp_name>`    | 
| <a name="home_compartment_id"></a> [home\_compartment\_id](#home\_compartment\_id)   | Provide Home Compartment OCID Value | `string` | `"<ocid.*>"`    |
| <a name="environment_compartment_id"></a> [environment\_compartment\_id](#environment\_compartment\_id])   | Provide Environment Compartment OCID Value | `string` | `"<ocid.*>"`    | 
| <a name="security_compartment_id"></a> [security\_compartment\_id](#security\_compartment\_id)   | Provide Security Compartment OCID Value | `string` | `"<ocid.*>"`    | 
| <a name="network_compartment_id"></a> [network\_compartment\_id](#network\_compartment\_id)   | Provide Network Compartment OCID Value | `string` | `"<ocid.*>"`    | 
| <a name="workload_compartment_id"></a> [workload\_compartment\_id](#workload\_compartment\_id)   | Provide Workload Compartment OCID Value | `string` | `"<ocid.*>"`    | 
| <a name="logging_compartment_id"></a> [logging\_compartment\_id](#logging_compartment_id)   | Provide Logging Compartment OCID Value | `string` | `"<ocid.*>"`    |

## 4.3 : DR and MR Feature Deployment.

* Step 1) Go to Folder templates/elz-backup/elz-backup-environment.
* Step 2) Provide variable values in the existing *Single_DR_Deployment.tfvars* file defined in section 4.1.
* Step 3) Provide the network, monitoring, identity, and security Module-related variables in the tfvars file. 
* Step 4) Execute the Following Terraform from the CLI.
  &nbsp;&nbsp;&nbsp;&nbsp;`terraform init`<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`terraform plan -var-file="Single_DR_Deployment.tfvars" -out oelz_dr_mr.out`<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`terraform apply oelz_dr_mr.out`<br />
* Step 5) Provisioning usually take 45-50 minutes.


# License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](../../LICENSE) for more details.
