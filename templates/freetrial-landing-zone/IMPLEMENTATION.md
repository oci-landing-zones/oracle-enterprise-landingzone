# Oracle Enterprise Landing Zone Infrastructure

## Prerequisites

To deploy the Oracle Enterprise Landing Zone Infrastructure OELZ from the terraform cli you will need the following prerequisites.
- [Latest Version of Terrafom](https://developer.hashicorp.com/terraform/downloads)
- [OCI Terraform provider](https://registry.terraform.io/providers/oracle/oci/latest/docs) v4.109.0 or later
- [oci - cli](https://github.com/oracle/oci-cli)

## User

The OELZ should be deployed by a user who is a member of the Administrators group for the tenancy. This user need to have an api key entry defined as decribed [here](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm). Once the user and API Key are defined your oci-cli config should resemble.

```text
[DEFAULT]
user=ocid1.xxxxxx.xxxxxx.xxxxxx.....  #ocid of the user
fingerprint=xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx #user api key fingerprint
tenancy=ocid1.xxxxxx.xxxxxx.xxxxxx..... #tenancy ocid
region=us-phoenix-1 #or desired region
key_file=<path to your private keyfile> # TODO
```

## Region

The OELZ should be deployed to the tenancy's Home Region.

## Tenancy

The tenancy you intend to deploy the OELZ to.

### Logging Analytics

The Logging Analytics service should be enabled for the tenancy.
To check the current status of Logging Analytics for a tenancy, visit the [Logging Analytics home page][1].
There will be a dark grey box at the top of the page. On the right hand side of that box, if Logging analytics has *not* been enabled, there will be a notice that Logging Analytics has not been enabled for the tenancy, and a blue button to enable it.  To enable it, click the blue button, and wait for the 3 onboarding steps to complete.  No further action will be required, as the Oracle Enterprise Landing Zone will configure the needed datasources.

### Resource Limits

Most of the initial resource limits a new tenancy comes with should be sufficient to deploy 1 OELZ, with 1 environments and 1 workload each. 

However, there are some resource limits that will need to be increased in order to deploy the Oracle Enterprise Landing Zone. Below is a table listing the Terraform OCI resource names and numbers deployed please ensure your tenancy has sufficient limts before deploying the Oracle Enterprise Landing Zone:

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

## Environments

---
Environments are each full infrastructure deployments with their own hub-and-spoke network, Identity domain, user groups, etc.


## Workloads

---
Workloads are the "shell" for you to deploy an application or service into. They provide infrastructure such as a compartment you can place application resources in, user groups to manage the application, network and logging infrastructure, etc. Workloads exist within Environments.


## Identity Domain

---
Environment will have its own identity domain with free tier identity domain. This lives in the Security compartment of each environment.  The identity domain applies to all resources under the environment compartment.OELZ will only support the new identity domains in OCI(Henosis) and not the old IDCS domains.Each domain has it's own users and groups, and can be federated and configured separately.

## Networking

---
Each environment will have it's own independent network configuration. The network architecture is a "Hub and Spoke" design. It is built around OCI's Dynamic Routing Gateway (DRG), which acts as central router. It can connect together multiple virtual networks like hub and spoke vcn. 

## Deployment of The Oracle Enterprise Landing Zone

## For customers who already have Infrastructure in OCI

If you already have infrastructure deployed in OCI and are looking to explore a best-practices infrastructure architecture with Oracle Enterprise Landing Zone, you may want to create a new [Child Tenancy](https://docs.oracle.com/en-us/iaas/Content/General/Concepts/organization_management_overview.htm) to deploy the Oracle Enterprise Landing Zone in. This will guarantee there are no conflicts with existing infrastructure.  

Note that child tenancies have their own [resource limits](#resource-limits), which should be checked to confirm the Oracle Enterprise Landing Zone can be deployed. 

## How to Deploy

---
The Oracle Enterprise Landing Zone can be launched through Oracle Resource Manager or from the Terraform CLI.

## Terraform CLI

* Clone the OELZ Terraform templates from the [oelz_github](https://github.com/oracle-quickstart/oci-landing-zones/tree/master).
*  Go to Directory landing-zones/templates/freetrial-landing-zone.
*  Configure Variables on the file landing-zones/templates/freetrial-landing-zone/livelab.tfvars and save the file.
    - Check Configuration Guide for Variables Deceralation. 
    
* Validate the changes . Issue the command "terraform validate".
    ![terraform_validate](<./images/terraform_validate.png> "terraform_validate")
* Initializes Terraform Configuration files via "terraform init".
    ![terraform_init](<.images/terraform_init.png> "terraform_init")
* Preview the changes that Terraform will to make to your infrastructure via "terraform plan -var-file=\"livelab.tfvars\"".
    ![terraform_plan_1](<./images/terraform_plan_1.png> "terraform_plan_1")
    ![terraform_plan_2](<./images/terraform_plan_2.png> "terraform_plan_2")
* Executes the changes defined by your Terraform configuration to create or update resources via "terraform apply -var-file=\"livelab.tfvars\"" and wait for atleast 10 min to finish provisioning.
    ![terraform_apply_1](<./images/terraform_apply_1.png> "terraform_apply_1")
    ![terraform_apply_2](<./images/terraform_apply_2.png> "terraform_apply_2")
    ![terraform_apply_3](<./images/terraform_apply_3.png> "terraform_apply_3")


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

## Teardown and destroy of an Oracle Enterprise Landing Zone Infrastructure

* Destroy the terraform configuration resources via "terraform destroy -var-file=\"livelab.tfvars\"".
    ![terraform_destroy_1](<./images/terraform_destroy_1.png> "terraform_destroy_1")
    ![terraform_destroy_2](<./images/terraform_destroy_2.png> "terraform_destroy_2")

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