# Landing Zones

This repository contains different types of Landing Zones to deploy to the Oracle Cloud Infrastructure platform. The landing zones are assembled from modules and templates that users can use in their default configuration or fork this repo and customize for your own scenarios.

## Oracle Enterprise Landing Zone v2 (OELZ v2)

The Oracle Enterprise Landing Zone v2 (OELZ v2) deploys a typical architecture used by enterprise customers. The root template for this landing zone is located at [templates/enterprise-landing-zone](./templates/enterprise-landing-zone). Users can use the guides below to get started with the Oracle Enterprise Landing Zone v2 (OELZ v2).

- [Architecture Guide](./templates/enterprise-landing-zone/Architecture_Guide.md)
- [Implementation Guide](./templates/enterprise-landing-zone/IMPLEMENTATION.md)
- [Configuration Guide](./templates/enterprise-landing-zone/CONFIGURATION.md)

### Workload Expansion
The Oracle Enterprise Landing Zone v2 (OELZ v2) deploys a workload in each environment (Prod and Non-Prod) by default.
The user can use the workload expansion stack to deploy additional customized workload. The template for the workload expansion is located
at [templates/elz-workload](./templates/elz-workload). Users can use the guides below to get started with Workload Expansion.
- [Implementation Guide](./templates/elz-workload/IMPLEMENTATION.md)
- [Configuration Guide](./templates/elz-workload/CONFIGURATION.md)

## Deploy Using Oracle Resource Manager
1. Click to deploy the stack

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/oracle-quickstart/oci-landing-zones/archive/refs/tags/v2.1.0.zip)

    If you aren't already signed in, when prompted, enter the tenancy and user credentials. Review and accept the terms and conditions.


2. Select the region where you want to deploy the stack.
3. For Working directory, select `templates/enterprise-landing-zone`
4. Follow the on-screen prompts and instructions to create the stack.
5. After creating the stack, click Terraform Actions, and select Plan.
6. Wait for the job to be completed, and review the plan.
7. To make any changes, return to the Stack Details page, click Edit Stack, and make the required changes. Then, run the Plan action again.
8. If no further changes are necessary, return to the Stack Details page, click Terraform Actions, and select Apply.


## The Team

This repository is developed and supported by the Oracle OCI Landing Zones team.

## How to Contribute

Interested in contributing?  See our contribution [guidelines](CONTRIBUTING.md) for details.

## License

This repository and its contents are licensed under [UPL 1.0](https://opensource.org/licenses/UPL).
