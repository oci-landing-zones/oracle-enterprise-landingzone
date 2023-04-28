# Oracle Enterprise Landing Zone

## Prerequisites

To deploy the Oracle Enterprise Landing Zone from the terraform cli you will need the following prerequisites.
- [Latest Version of Terrafom](https://developer.hashicorp.com/terraform/downloads)
- [OCI Terraform provider](https://registry.terraform.io/providers/oracle/oci/latest/docs) v4.109.0 or later
- [oci - cli](https://github.com/oracle/oci-cli)

## User

The Oracle Enterprise Landing Zone should be deployed by a user who is a member of the Administrators group for the tenancy. This user need to have an api key entry defined as decribed [here](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm). Once the user and API Key are defined your oci-cli config should resemble.

```text
[DEFAULT]
user=ocid1.xxxxxx.xxxxxx.xxxxxx.....  #ocid of the user
fingerprint=xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx #user api key fingerprint
tenancy=ocid1.xxxxxx.xxxxxx.xxxxxx..... #tenancy ocid
region=us-phoenix-1 #or desired region
key_file=<path to your private keyfile> # TODO
```

## Region

The Oracle Enterprise Landing Zone should be deployed to the tenancy's Home Region.

## Tenancy

The tenancy you intend to deploy the Oracle Enterprise Landing Zone to.

### Logging Analytics

The Logging Analytics service should be enabled for the tenancy.
To check the current status of Logging Analytics for a tenancy, visit the [Logging Analytics home page][1].
There will be a dark grey box at the top of the page. On the right hand side of that box, if Logging analytics has *not* been enabled, there will be a notice that Logging Analytics has not been enabled for the tenancy, and a blue button to enable it.  To enable it, click the blue button, and wait for the 3 onboarding steps to complete.  No further action will be required, as the Oracle Enterprise Landing Zone will configure the needed datasources.

### Resource Limits

Most of the initial resource limits a new tenancy comes with should be sufficient to deploy 1 Oracle Enterprise Landing Zone, with 2 environments and 1 workload each. 

However, there are some resource limits that will need to be increased in order to deploy the Oracle Enterprise Landing Zone. Below is a table listing the Terraform OCI resource names and numbers deployed please ensure your tenancy has sufficient limts before deploying the Oracle Enterprise Landing Zone:
|OCI Terraform Resource Name | Count   |
| ---------------------------- | ------- |
|oci_announcements_service_announcement_subscription| 2|
|oci_announcements_service_announcement_subscriptions_filter_group| 4|
|oci_bastion_bastion| 2|
|oci_budget_alert_rule| 2|
|oci_budget_budget| 2|
|oci_cloud_guard_cloud_guard_configuration| 2|
|oci_cloud_guard_target| 2|
|oci_core_cpe| 1|
|oci_core_default_security_list| 4|
|oci_core_drg| 2|
|oci_core_drg_attachment| 4|
|oci_core_internet_gateway| 2|
|oci_core_ipsec| 1|
|oci_core_ipsec_connection_tunnel_management| 2|
|oci_core_nat_gateway| 4|
|oci_core_route_table| 6|
|oci_core_security_list| 4|
|oci_core_service_gateway| 4|
|oci_core_subnet| 10|
|oci_core_vcn| 4|
|oci_events_rule| 12|
|oci_identity_authentication_policy| 1|
|oci_identity_compartment| 13|
|oci_identity_domain| 2|
|oci_identity_dynamic_group| 1|
|oci_identity_policy| 49|
|oci_identity_tag| 7|
|oci_identity_tag_default| 7|
|oci_identity_tag_namespace| 3|
|oci_kms_key| 3|
|oci_kms_vault| 2|
|oci_log_analytics_log_analytics_log_group| 4|
|oci_logging_log| 18|
|oci_logging_log_group| 2|
|oci_monitoring_alarm| 68|
|oci_objectstorage_bucket| 7|
|oci_ons_notification_topic| 20|
|oci_sch_service_connector| 16|
|oci_streaming_stream| 2|
|oci_streaming_stream_pool| 2|
|oci_vulnerability_scanning_host_scan_recipe| 2|
|oci_vulnerability_scanning_host_scan_target| 2| 

Example to check the limits in tenancy:

1.	Login to OCI Console and click on the left top corner burger menu. 
2.	Scroll down and click on Governance and Administration 
3.	Under Tenancy Management click on Limits, Quotas and Usage Option 

![ScreenShot1](</images/p1.png> "ScreenShot1")

4.	Under Service option select Service Connector Hub and it will show how much is the limit, used and available.

![ScreenShot2](</images/p2.png> "ScreenShot2")

Also, this link can provide all the details on limits, quotas and usage as to how use, request increase etc.

https://docs.oracle.com/en-us/iaas/Content/General/Concepts/servicelimits.htm

Requests to raise these limits can be done through the [request a service limit increase][2] page. 

[1]: https://cloud.oracle.com/loganalytics/home "Logging Analytics Home page."
[2]: https://cloud.oracle.com/support/create?type=limit "Request a service Limit Increase."

## Oracle Enterprise Landing Zone Compartment Architecture

---
![Architecture](<../../images/LZ-v2.0.png> "Architecture")

This architecture diagram illustrates the compartments Enterprise LZ deployments

### Compartment Structure

For the Oracle Enterprise Landing Zone, we have the below compartment architecture:

* Oracle Enterprise Landing Zone Home Compartment
  * Prod
    * Shared Infrastructure
      * Network
      * Security
    * Workload
    * Logging
    * Backup
  * Non Prod
    * Shared Infrastructure
        * Network
        * Security
    * Workload
    * Logging
    * Backup

## Environments

---
Environments are each full infrastructure deployments with their own hub-and-spoke network, Identity domain, user groups, etc.

They are designed to ensure isolation between each environment. They can each contain multiple Workloads.

The Oracle Enterprise Landing Zone will initially set up two Environments: `Prod` and `Nonprod`.  Infrastructure resources within each Environment will have a single letter abbreviation (such as `N` or `P`) to indicate which environment they are part of.

In the future, the `elz-environment` template will allow you to easily add new Environments to an existing Oracle Enterprise Landing Zone.

## Workloads

---
Workloads are the "shell" for you to deploy an application or service into. They provide infrastructure such as a compartment you can place application resources in, user groups to manage the application, network and logging infrastructure, etc.

Workloads exist within Environments.

The Oracle Enterprise Landing Zone will set up one initial workload configuration in each Environment. In the future, the `elz-workload` template  will allow you to easily add additional workloads to a deployed Environment within the Oracle Enterprise Landing Zone.

Note that Workload compartments and networks all contain a user provided *workload_name* suffix in their names. This allows multiple workloads, each with their own separate compartment and networks, to be deployed.

## Identity Domain

---
Each environment will have its own identity domain. This lives in the Security compartment of each environment.  The identity domain applies to all resources under the environment compartment.
Oracle Enterprise Landing Zone will only support the new identity domains in OCI(Henosis) and not the old IDCS domains.

Each domain has it's own users and groups, and can be federated and configured separately.

## Networking

---
Each environment will have it's own independent network configuration. The network architecture is a "Hub and Spoke" design. It is built around OCI's Dynamic Routing Gateway (DRG), which acts as central router. It can connect together multiple virtual networks, as well as VPN or FastConnect links to on-premises networks.  

Each environment will have one Hub virtual network (VCN) that hosts network infrastructure shared between all workloads, such as load balancers and firewalls. This will have one Public and one Private subnet.

For *each* workload deployed in an environment, there will be one Spoke network. This will have three private subnets, one each for Web, DB and Application resources.

The `elz-network-extension` template can add VPN or FastConnect links between an environment's DRG and an on-prem network.

## Deployment of The Oracle Enterprise Landing Zone

## For customers who already have Infrastructure in OCI

If you already have infrastructure deployed in OCI and are looking to explore a best-practices infrastructure architecture with Oracle Enterprise Landing Zone, you may want to create a new [Child Tenancy](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/organization_management_overview.htm) to deploy the Oracle Enterprise Landing Zone in. This will guarantee there are no conflicts with existing infrastructure.  

Note that child tenancies have their own [resource limits](#resource-limits), which should be checked to confirm the Oracle Enterprise Landing Zone can be deployed. 

## How to Deploy

---
The Oracle Enterprise Landing Zone can be launched through Oracle Resource Manager or from the Terraform CLI.

## Terraform CLI

1. Have Terraform installed on the system you will deploy from. The Oracle Enterprise Landing Zone should work with any version of Terraform greater than 1.0.0, including the latest version (currently 1.3.9).  If you do not have Terraform already installed, the [Terraform Download page](https://developer.hashicorp.com/terraform/downloads) will have links for the proper package for your system, and installation instructions. 

2. Set up API keys to work with your OCI account. Follow the instructions [here](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm).

3. Visit the [GitHub page](https://github.com/oracle-quickstart/oci-landing-zones) to clone the Terraform template.

4. In the repository, cd to the `templates/enterprise-landing-zone/` directory. This is the main template for the Oracle Enterprise Landing Zone. (the other templates will allow you to deploy other components, such as additional Environments or Workloads, or to deploy pieces of the Oracle Enterprise Landing Zone architecture for use in your own custom infrastructure designs.)

5. Create a terraform.tfvars file in the directory and populate it with the required variables or override existing variables. 
**For reference on the configuration variable values read the [Configuration Guide](CONFIGURATION.md). For a full list of all available configuration variables see the [Input Variables Reference in the README](README.md#inputs)**

    Note: An example tfvars file is included for reference. Using this file is the preferred way to run the stack from the CLI, because of the large number of variables to manage. 

6. From the root of the module run the following commands to deploy the terraform.
   * `terraform init`
   * `terraform plan`
   * `terraform apply`

7. Terraform will provision your resources and provide outputs once it completes.

### For more information 

- [Deploy to OCI using Terraform tutorials](https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/tf-provider/01-summary.htm).

- [OCI provider documentation](https://registry.terraform.io/providers/oracle/oci/latest/docs).

## Resource Manager

To deploy using Resource Manager, the stack must be imported into the console in one of 2 ways:

Use the `Deploy to Oracle Cloud` button which will take you directly to OCI Resource Manager if you are logged in. You can skip to step 11 if you use this.
Or you can select the stack manually through the console starting from step 1. 

1. From the console home page, navigate to `Developer Services -> Resource Manager -> Stacks`
2. Select the compartment you want to create the stack in and select `Create stack`.
3. Select `Source code control system` for the Terraform source.
4. In the `Stack Configuration` box, under `Source Code Management Type`, select `GitHub`. 
5. Under `Configuration source provider`, if you have a provider set up for public GitHub, you can select it, then skip to step 9. Otherwise select `Create configuration source provider`. 
6. If you do not already have a Personal Access Token for your GitHub account, log in to GitHub and create one. The option can be found under `Settings -> Developer settings -> Personal access tokens -> Tokens (classic)` on the [GitHub site](https://github.com). The token must have the `repo` scope. 
7. To create the configuration provider for GitHub in OCI, fill in the "Create configuration source provider" form as follows: 
    * Name: GitHub
    * Description: (optional) Public Github Repositories
    * Select the `Public Endpoint` option
    * Type: GitHub
    * Server URL: https://github.com/
    * Personal Access Token: #Your Personal Access Token# 
8. Click `Create` to create the config provider
9. For Repository select `oci-landing-zones`
10. For Branch select `main`
11. for Working directory, select `templates/enterprise-landing-zone`    

12. For Name, give the stack a name or accept the default.
13. For the Create in Compartment dropdown, select the compartment to store the Stack.
14. For Terraform Version dropdown, make sure to select 1.0.x at least. Lower Terraform versions are not supported.

After completing the Stack Creation Wizard, the subsequent step prompts for variables values. **For reference on the configuration variable values read the [Configuration Guide](CONFIGURATION.md). For a full list of all available configuration variables see the [Input Variables Reference in the README](README.md#inputs)**

After filling in the required input variables, click next to review the stack values and create the stack.

In the Stack page use the appropriate buttons to plan/apply/destroy your stack.

### For more information

- [Resource Manager Overview](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Concepts/resourcemanager.htm)

## Teardown and destroy of an Oracle Enterprise Landing Zone stack

If you wish to delete an entire Oracle Enterprise Landing Zone stack, there are a few resources that will require some manual intervention due to dependancies or conditions that are outside of Terraform's knowledge. 

The steps to clean up these resources is as follows: 

1. Bucket Removal (For each Environment)
    * Navigate to the audit bucket, default bucket, and service event bucket in the logging compartment, and archive bucket in the home compartment.
    * For each bucket:
      * Delete the retention rules: on the bucket page, navigate to Resource → Retention Rules.
      * Delete all the objects in the bucket: on the bucket page, navigate to Resource → Objects.
      * Delete the bucket.

2. Identity Domain (For each Environment)

    * Deactivate the identity domain created in the security compartment for each env: on the Identity Domain page, navigate to More actions → Deactivate.
    * Delete the identity domain. 

3. Vault/Key (For each Environment)

    * The vault cannot be deleted right away. Vaults have a minimum 7-Day waiting period before deletion. This is because once the Vault is deleted, all data encrypted with keys in that Vault becomes unreadable. 
    * You can move the vault and the Master Encryption Key to another compartment outside the Oracle Enterprise Landing Zone home before deleting it in order to delete the landing zone.
    * Or you can schedule a deletion for the key and the vault, and then wait to delete the Oracle Enterprise Landing Zone when the Vault and key have been deleted. 

4. Logging Analytics

    * Purge the log: navigate to the Administration page of Logging Analytics → click the storage under the Resources section → Purge Logs
    * (Optional) Delete the Logging Analytics group.

Once these resources have been removed, you will be able to use Terraform to delete the rest of the Oracle Enterprise Landing Zone. If using terraform CLI: run `terraform destroy` to remove other resources. If using ORM: navigate to the corresponding stack created and click  `Destroy`.

#### Cleanup Script
A clean up script is provided to assist in cleaning up lingering resources that block terraform destroy.
It can be found at `./destroy_lz.py`

Once the script has been run, service connectors, buckets, and log analytics log groups will be deleted, identity domains deactivated, and vaults moved to the root compartment. 
Terraform destroy will need to be run after.

1. To run the script ensure you have **python3** installed as well as an **oci api key**.
   * install python [here](https://www.python.org/downloads/)
   * set up api keys [here](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm)

2. Verify the profile name(eg. DEFAULT) by checking the config file found at `~/.oci/config` (if the profile you want to use is not DEFAULT use the `--profile` flag to indicate).

3. Install dependencies using the command: 
    ```
    pip install oci tqdm
    ```

4. Run the command (from the templates/enterprise-landing-zone directory)
    ```
    python destroy_lz.py -r IAD -e P N -c OCI-ELZ-CMP-HOME 
    ```

The `-r` flag indicates the 3 letter region key, the `-e` indicates the environment prefix, such as production and non-production, and the `-c` indicating the home compartment. 

For more information on flag usage for the script use the `--help` flag.
```
python destroy_lz.py  --help
```

## Known Issues

---
These are some known temporary issues that can occur while deploying the Oracle Enterprise Landing Zone. 

* 400-InvalidParameter Error in CreateServiceConnector operation:  This can occasionally happen due to logs taking longer than normal to create while setting up the logging infrastructure.  This will correct itself when the logs finish creating. Later Apply jobs in ORM or invocations of `terraform apply` should succeed. 
* 429-TooManyRequests Error: A tenancy making a large number of OCI API requests in rapid succession may be throttled by the API.  The solution is to wait some period of time (a few minutes) and retry the terraform operation again.  This is rarely seen on `apply` but may occasionally be seen on `destroy` runs, as the delete operations are much faster than create, and Terraform makes many API calls. 