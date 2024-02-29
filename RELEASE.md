# Release Notes

## v2.3.1 - 2024-2-29
-  Move Bastion resources to workload stack module.
-  Added Flag to deploy Non-Production Environment as per customer need.
-  Removed cloud guard target tenancy variable and changed default to Environment Home Compartment OCID.
-  Added Access Governance Module on OELZ.


## v2.3.0 - 2024-1-19
-  Added Multi-Region and Disaster Recovery Module.
-  Cloud Guard Key Replication from the Home Region to the Backup Region or vice-verse is currently not supported(Work in Progress).
  
## v2.2.0 - 2023-10-11

- Network Firewall Feature is added.(Greenfield & Brownfield use cases)
- Oracle Data Safe Feature has been added for Workload Databases.
- OCI Provider version is Upgraded to 5.9.0 from 5.1.0 .
- All Documentation are moved to Root Folder.

Customer Issues resolved as part of this Release

- With bastion service disabled terraform fails with prod_bastion_client_cidr_block_allow_list error #58
- Reorg of OELZ v2 documentations #6
- Error:400-InvalidParameter, creating workload_osms_dg_policy #99
- Error:400-InvalidParameter, Compartment {ocid1.compartment.oc1....} does not exist or is not part of the policy compartment subtree #100
- Separate AdminGroups for each Workload #85.
- Security + OCI Administrators architecture Question #69.
- Typo: Platform Admin Group Policy To Manage Archive Bucket #75
- 400-InvalidParameter Invalid Oracle_Managed_Recipe_Configuration #92

## v2.1.2 - 2023-07-26
- Initial Workload Name has to be parameterized Initial Workload Name has to be parameterised #23
  - Added New Variable "workload_name_prefix" to define the Workload Name.
- Policies required for destroy landing zone Policies required for destroy landing zone #71
  - Added Policy to allow Oracle Logging Analytics service READ access rights of the family loganalytics-features-family across the tenancy
- OCI Team Please create a brand new tenancy (With default settings) OCI Team Please create a brand new tenancy (With default settings) #62
  - Updated the IMPLEMENTATION.md with OCI terminalogies corresponding to there terraform API call
- Break-glass user email should be optional in ORM stack template Break-glass user email should be optional in ORM stack template #17
  - Break-glass user email is mandatory, updated the CONFIGURATION.md
- Osms dynamic group for Workload expansion osms dynamic group for Workload expansion #24
  - Added OSMS Dynamic Group on Workload Compartment.

## v2.1.1 - 2023-07-10
- Fixed the Tagging Namespace Issue (tagging limit #61)
  - Added the Flag to disble the Tag per module. Earlier the tag are created per module which impacted OELZ deployment time and in certain cases tenancy tag service limit has been hit.
- Fixed the Bucket Log Rotation issue.
  - While re-deploying the Workload template with changed resources parameter we had seen the Bucket resources had been modified which is causing issue. Added the functionality on bucket resources which will not impact bucket resources by any future changes. 
- Fixed Database Admins need higher IAM privileges (Issue #15)
- Workload Exadata Module has been added. The Exadata expansion template can allow you to integrate and prepare the environment to host your Exadata infrastructure within the OELZ workload expansion module. This template also enables Oracle Data Safe to improve the database security posture.

----
## v2.1.0 - 2023-06-05
- Initial Release of Workload Expansion Stack. The Workload Expansion template is responsible for deploying the resources for an empty workload. The user can use the workload expansion stack to deploy additional customized workload.
  Workload Expansion template will deploy the following resources:
  - Compartment
  - Network (Spoke)
  - Logging
  - Monitoring
  - Policies and workload group
- Refactoring Network module. The network module was refactored to the Hub module and the Spoke module. The Hub module deploys the main network resource using for baseline stack and the spoke module deploys resource using for workload stack.

## v2.0.0 - 2023-02-28
- Initial Release of new version 2 codebase with Hub and Spoke Networking, Multi-Environment support and more modular architecture. see the [Architecture Guide](./templates/enterprise-landing-zone/Architecture_Guide.md) for details.
- CIS Security Benchmark Compliance: Oracle Enterprise Landing Zone v2 was designed to include a foundational set of security controls from the Center for Internet Security (CIS). We are happy to share that this release of Landing Zones will support the recommended CIS 1.2 Level 1 controls. The security controls implemented by this Landing Zone are prescriptive and practical in nature with the primary focus to help provide best practices for security hardening of the technologies that are deployed in our customers' tenancies.
While many of the CIS Level 1 recommendations are included in the Landing Zone deployment, however, there are some that require administrators to configure manually. Please be advised that for recommendations # 1.5 - 1.13, 2.6 - 2.8 and 3.16, it will be the customer administrators' responsibility to implement and enforce.
For recommendation #1.7, we recommend that Multi-Factor Authentication (MFA) be fully tested before restricting access only to MFA-verified users. Please note each user must enable MFA for themselves and an administrator cannot enable MFA for another user. For more information, please see [OCI Managing Multi-Factor Authentication documentation][v2.0.0-1].
For more information on the CIS Security Benchmark, please visit the official [Oracle Cloud CIS Benchmark site][v2.0.0-2].
- Certain CIDR ranges should not be used when deploying OELZv2, as the can conflict with IP addresses reserved for special use. These are:
    * 169.254.10.0-169.254.19.255
    * 169.254.100.0-169.254.109.255
    * 169.254.192.0-169.254.201.255
    * 100.64.0.0–100.127.255.255 (Used by Exadata X8M/X9M for the interconnect)
- Known Issues
  * 400-InvalidParameter Error in CreateServiceConnector operation:  This can occasionally happen due to logs taking longer than normal to create while setting up the logging infrastructure.  This will correct itself when the logs finish creating. Later Apply jobs in ORM or invocations of `terraform apply` should succeed.
  * 429-TooManyRequests Error: A tenancy making a large number of OCI API requests in rapid succession may be throttled by the API.  The solution is to wait some period of time (a few minutes) and retry the terraform operation again.  This is rarely seen on `apply` but may occasionally be seen on `destroy` runs, as the delete operations are much faster than create, and Terraform makes many API calls. 

[v2.0.0-1]: https://docs.oracle.com/en-us/iaas/Content/Identity/Tasks/usingmfa.htm
[v2.0.0-2]: https://www.cisecurity.org/benchmark/oracle_cloud


## License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](./LICENSE) for more details.
