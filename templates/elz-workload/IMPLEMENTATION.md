# Enterprise Scale Baseline Landing Zone Workload Extension

## Prerequisites

1) To deploy the Enterprise Scale Baseline Landing Zone Workload Expansion from the terraform cli you will need the following prerequisites.
- [Latest Version of Terrafom](https://developer.hashicorp.com/terraform/downloads)
- [OCI Terraform provider](https://registry.terraform.io/providers/oracle/oci/latest/docs) v4.109.0 or later
- [oci - cli](https://github.com/oracle/oci-cli)

2) Enterprise Scale Baseline Landing Zone is deployed. 

## User

The Enterprise Scale Baseline Landing Zone Workload Expansion should be deployed by a user who is a member of the Administrators group for the tenancy. This user need to have an api key entry defined as decribed [here](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm). Once the user and API Key are defined your oci-cli config should resemble.

```text
[DEFAULT]
user=ocid1.xxxxxx.xxxxxx.xxxxxx.....  #ocid of the user
fingerprint=xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx #user api key fingerprint
tenancy=ocid1.xxxxxx.xxxxxx.xxxxxx..... #tenancy ocid
region=us-phoenix-1 #or desired region
key_file=<path to your private keyfile> # TODO
```

## Region

The Enterprise Scale Baseline Landing Zone Workload will be deployed as L3 on user defined Parent Compartment OCID.

### Resource Limits
TBD

### Compartment Structure

For the Enterprise Scale Baseline Landing Zone, we have the below compartment architecture:

* Enterprise Scale Baseline Landing Zone Workload Compartment will be deployed on user defined Parent Compartment OCID. So there are two deployment scenario.

1) First Case : Workload Expansion will be deployed On Prod Environment.
  * Prod
    * Shared Infrastructure
      * Network
      * Security
    * Workload
    * Logging
    * Backup 
    * Workload Expansion 

2) Second Case : Workload Expansion will be deployed On Non-Prod Environment.
  * Non Prod
    * Shared Infrastructure
        * Network
        * Security
    * Workload
    * Logging
    * Backup
    * Workload Expansion 

### Workload Expansion : Network

ESBLZ Workload Expansion Stack will deploy one Spoke VCN on user defined Compartment. It will deploy VCN Gateway like Nat Gateway and Service Gateway, Security Rules and Route Tables as per the User prefence and will attach the VCN to configured DRG. There will be three Subnets for Web ,App and DB Application Resources.


Logging for the Enterprise Scale Baseline Landing Zone is configured at the Environment level, with logs for all Workloads within a given Environment being sent to object storage buckets set up per-environment, as well as an archive bucket for all Environments, with a long term retention policy. No logging configuration per Workload is necessary. 

### Workload Expansion : Policy 

As part of Workload Expansion three user groups will be created Workload Admin, Application Admin and Database Admin. We are adding default policy so that newly created user groups have fine-grained access to workload resources. 

### Workload Expansion : Monitoring

The Workload Expansion will create a series of monitoring alarms (11 Critical alarms, and 6 Warning alarms) for each Workload it creates. Notifications created by these alarms being triggered will be delivered by email to a list of email addresses (The workload_topic_endpoints) specified for that Workload. 