# Oracle Enterprise Landing Zone Workload Expansion

## Prerequisites

1) To deploy the Oracle Enterprise Landing Zone Workload Expansion from the terraform cli you will need the following prerequisites.
- [Latest Version of Terrafom](https://developer.hashicorp.com/terraform/downloads)
- [OCI Terraform provider](https://registry.terraform.io/providers/oracle/oci/latest/docs) v4.109.0 or later
- [oci - cli](https://github.com/oracle/oci-cli)

2) **Oracle Enterprise Landing Zone is deployed.**
3) If users need to deploy multiple workloads, they need to copy and paste elz-worload folder to deploy each workload separately.

## Deployment

### Terraform CLI

1. Have Terraform installed on the system you will deploy from. The Oracle Enterprise Landing Zone should work with any version of Terraform greater than 1.0.0, including the latest version (currently 1.3.9).  If you do not have Terraform already installed, the [Terraform Download page](https://developer.hashicorp.com/terraform/downloads) will have links for the proper package for your system, and installation instructions.

2. Set up API keys to work with your OCI account. Follow the instructions [here](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm).

3. Visit the [GitHub page](https://github.com/oracle-quickstart/oci-landing-zones) to clone the Terraform template.

4. In the repository, cd to the `templates/elz-workload/` directory. This is the main template for the Workload Expansion.

5. **Create a terraform.tfvars file in the directory and populate it with the required variables or override existing variables.**
   **For reference on the configuration variable values read the [Configuration Guide](CONFIGURATION.md). For a full list of all available configuration variables see the [Input Variables Reference in the README](README.md#inputs)**

   **Note: An example tfvars file (workload_extension.tfvars) included for reference. Using this file is the preferred way to run the stack from the CLI, because of the large number of variables to manage.**

6. From the root of the module run the following commands to deploy the terraform.
    * `terraform init`
    * `terraform plan`
    * `terraform apply`

7. Terraform will provision your resources and provide outputs once it completes.

### Resource Manager
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
11. for Working directory, select `templates/elz-workload`

12. For Name, give the stack a name or accept the default.
13. For the Create in Compartment dropdown, select the compartment to store the Stack.
14. For Terraform Version dropdown, make sure to select 1.0.x at least. Lower Terraform versions are not supported.

After completing the Stack Creation Wizard, the subsequent step prompts for variables values. **For reference on the configuration variable values read the [Configuration Guide](CONFIGURATION.md). For a full list of all available configuration variables see the [Input Variables Reference in the README](README.md#inputs)**

After filling in the required input variables, click next to review the stack values and create the stack.

In the Stack page use the appropriate buttons to plan/apply/destroy your stack.

### After Deploying Workload Expansion
Users need to go back to the baseline stack `enterprise-landing-zone` to re-run terraform apply to update baseline configuration.

#### Terraform CLI
1. Navigate to the baseline stack `enterprise-landing-zone`.
2. Add two variables into your tfvars file

| Name                                                                                                              | Description                                                                                                   | Type           | Default         | Required |
| ----------------------------------------------------------------------------------------------------------------- |---------------------------------------------------------------------------------------------------------------|----------------| --------------- | :------: |
| <a name="nonprod_additional_workload_subnets_cidr_blocks"></a> [nonprod_additional_workload_subnets_cidr_blocks](#workload\_admin\_group\_name)             | List of 3 subnets CIDR Block used in workload expansion. (Do not include the cidr blocks created in baseline) | `list(string)` |  |    yes    |
| <a name="nonprod_workload_compartment_names"></a> [nonprod_workload_compartment_names](#application\_admin\_group\_name)             | Workload compartment name. (Also include the workload name created in baseline)                               | `list(string)` |  |    yes    |

or your workload expansion was deployed in Prod:

| Name                                                                                                              | Description                                                                      | Type           | Default         | Required |
| ----------------------------------------------------------------------------------------------------------------- |----------------------------------------------------------------------------------|----------------| --------------- | :------: |
| <a name="prod_additional_workload_subnets_cidr_blocks"></a> [prod_additional_workload_subnets_cidr_blocks](#workload\_admin\_group\_name)       | List of 3 subnets CIDR Block used in workload expansion.(Do not include the cidr blocks created in baseline)                         | `list(string)` |  |    yes    |
| <a name="prod_workload_compartment_names"></a> [prod_workload_compartment_names](#application\_admin\_group\_name)             | Workload compartment name.  (Also include the workload name created in baseline) | `list(string)` |  |    yes    |

3. From the root of the module run the following commands to deploy the terraform.
    * `terraform init`
    * `terraform plan`
    * `terraform apply`
4. The subnet CIDR blocks are used to update the route table in Hub.
5. The workload name is used to update the related policy in the environment.

#### Resource Manager
1. Navigate to the baseline stack in Resource Manager.
2. Go to Variables section of the baseline stack, add the value of `nonprod_additional_workload_subnets_cidr_blocks` and `nonprod_workload_compartment_names` or `prod_additional_workload_subnets_cidr_blocks` and `prod_workload_compartment_names`.
3. Click "Terraform Apply" to update the stack
## User

The Oracle Enterprise Landing Zone Workload Expansion should be deployed by a user who is a member of the Administrators group for the tenancy. This user need to have an api key entry defined as decribed [here](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm). Once the user and API Key are defined your oci-cli config should resemble.

```text
[DEFAULT]
user=ocid1.xxxxxx.xxxxxx.xxxxxx.....  #ocid of the user
fingerprint=xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx #user api key fingerprint
tenancy=ocid1.xxxxxx.xxxxxx.xxxxxx..... #tenancy ocid
region=us-phoenix-1 #or desired region
key_file=<path to your private keyfile> # TODO
```

## Region
The Oracle Enterprise Landing Zone Workload will be deployed as L3 on user defined Parent Compartment OCID.


### Compartment Structure

For the Oracle Enterprise Landing Zone, we have the below compartment architecture:

* Oracle Enterprise Landing Zone Workload Compartment will be deployed on user defined Parent Compartment OCID. So there are two deployment scenario.

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

OELZ Workload Expansion Stack will deploy one Spoke VCN on user defined Compartment. It will deploy VCN Gateway like Nat Gateway and Service Gateway, Security Rules and Route Tables as per the User prefence and will attach the VCN to configured DRG. There will be three Subnets for Web ,App and DB Application Resources.


Logging for the Oracle Enterprise Landing Zone is configured at the Environment level, with logs for all Workloads within a given Environment being sent to object storage buckets set up per-environment, as well as an archive bucket for all Environments, with a long term retention policy. No logging configuration per Workload is necessary. 

### Workload Expansion : Policy

As part of Workload Expansion three user groups will be created Workload Admin, Application Admin and Database Admin. We are adding default policy so that newly created user groups have fine-grained access to workload resources. 

### Workload Expansion : Monitoring

The Workload Expansion will create a series of monitoring alarms (11 Critical alarms, and 6 Warning alarms) for each Workload it creates. Notifications created by these alarms being triggered will be delivered by email to a list of email addresses (The workload_topic_endpoints) specified for that Workload. 
