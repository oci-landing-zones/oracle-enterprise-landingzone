# Oracle Enterprise Landing Zone Disaster Recovery(DR)/ Multi Region(MR)

# Table of Contents

1. [Introduction](#introduction)
1. [Disaster Recovery](#considerations)
1. [Multi Region](#architecture)
1. [Deployment Samples](#samples)


# <a name="introduction"></a>1. Introduction

A disaster can be any event that puts your applications at risk, from network outages to equipment failures to natural disasters. A well-architected disaster recovery plan enables you to recover quickly from disasters and continue to provide services to your users.

Oracle Cloud Infrastructure (OCI) provides highly available, secure, and scalable infrastructure and services that enable you to recover your cloud workloads quickly, reliably, and securely. A natural disaster can cause an entire OCI region to be out of service. This scenario is one of the most severe cases in your disaster recovery design. To protect against this scenario, deploy your workloads across multiple OCI regions. Depending on your disaster recovery goals, whether recovery time or point objectives (RTO and RPO), you can back up or replicate your data to another region.

This repo is under active development. Building open-source software is a community effort. We're excited to engage with the community, and we welcome contributors.


# <a name="Disaster Recovery"></a>2. Disaster Recovery

## 2.1 Introduction

Disaster recovery (DR) plan enables you to recover quickly from disasters and continue to provide services to your users.

DR is the process of preparing for and recovering from a disaster. A disaster can be any event that puts your applications at risk, from network outages to equipment and application failures to natural disasters. It's almost impossible to predict when you will need disaster recovery, just like you can't predict when you'll get in a car accident. If you can't control when a disaster strikes, the next best thing is to be able to control the recovery process. 

## 2.2 Design Consideration

The module will allow the customer to deploy an additional OELZ infrastructure to the existing OELZ v2 in another region in order to enable Disaster Recovery or just create another OELZ.

The Disaster Recovery Feature will able to deploy identical resources for a using Disaster Recovery Warm stand-by Approach.

# <a name="Multi Region"></a>3. Multi Region

## 3.1 Introduction

Multi Region Replication replicate the OELZ resources on the paired backup region. By Default we are only supporting paried backup region where all identity resources are by default replicated to paired backup region and others OELZ resources will be replicated by new code. 


## 3.2 Design Consideration

# <a name="Deployment Samples"></a>Deployment Samples

## 4.1 : DR and MR Related New Variables


## 4.2 : Deploy OELZ Feature on Primary and Paired Backup Region.

| Variable Name      | Description| Type | Default
| ------------------- | ----- | ----- | ----- |
| <a name="enable_landing_zone_replication"></a> [enable\_landing\_zone\_replication](#enable\_network\_firewall\_prod)   | Enable Multi Region  Replication in Both Environment | `boolean` | `"false"`    | 
| <a name="backup_region"></a> [backup\_region](#enable\_network\_firewall\_prod)   | Enter Paried Backup Region Name | `string` | `"<>"`    | 


* Step 1) Go to folder templates/enterprise-landing-zone.
* Step 2) Provide variable values in the existing *example.tfvars* file. Add the following Network Firewall Related Variables on *example.tfvars* file.<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`enable_landing_zone_replication   = "true"` <br />
* Step 3) Use any deployment scenario in Section 5. We are using the terraform CLI (Section 5.1) method.
* Step 4) Execute the Following.<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`terraform init`<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`terraform plan -var-file="example.tfvars" -out oelz_nfw.out`<br />
  &nbsp;&nbsp;&nbsp;&nbsp;`terraform apply oelz_nfw.out`<br />
* Step 5) Network Firewall Provisioning usually take 45-50 minutes.


## 4.2 Deploy the OELZ on Paried Backup Region After OELZ deployment on Primary Region.

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
