# Architectural Guide

# **Intro**

As described in the previous version of the Oracle Oracle Enterprise Landing Zone v1, the new Oracle Oracle Enterprise Landing Zone v2.0 (OELZ v2.0)  is a set of foundational services and components that are deployed in a customer's OCI tenancy to establish a secure and scalable network foundation for running enterprise workloads.

The new version of Oracle Cloud Infrastructure (OCI) Oracle Enterprise Landing Zone is a set of Terraform modules that are designed to make it easy to set up a secure and compliant multi-account infrastructure on OCI. Some common use cases for OCI Oracle Enterprise Landing Zone include:

- Multi-cloud architectures: The OELZv2 can be used to create a landing zone for connecting to other clouds, such as Azure, for a hybrid cloud architecture.
- Governance and compliance: The OELZv2 provides a set of pre-built policies and guardrails that help ensure that your OCI environment is compliant with industry standards, such as ISO27001 and PCI DSS (these and other compliance standards will be part of ongoing releases).
- Automation and scalability: The Landing Zone can be used to automate the creation of new accounts, users, and resources on OCI, making it easy to scale your infrastructure as your organization grows.

# **Primary Objectives**

The primary objectives of the OELZv2 zone include the following items:

- Reduce time-to-start and deploy.
- Provide an architecturally strong foundation.
- Maintain the flexibility to customize and evolve the implementation to your organization's needs.

# **Key Design Principles**

Key design principles for resiliency and security ensure that the OELZv2 zone deploys a strong foundation for your cloud environment.

## **_Resiliency_**

A resilient cloud architecture helps you to avoid single points of failure for your cloud-based workloads.

At the infrastructure level, OCI provides physical and logical resources to help you design for resiliency, such as [regions, availability domains, and fault domains](https://docs.oracle.com/iaas/Content/General/Concepts/regions.htm).

Resiliency depends on the nature, architecture, and implementation of the workloads that you plan to deploy on OCI. For best practices, see [Resilience and Continuous Availability of Oracle Cloud Infrastructure Services and Platform FAQ](https://www.oracle.com/cloud/iaas/faq.html) and [Best practices for designing reliable and resilient cloud topologies](https://docs.oracle.com/en/solutions/oci-best-practices-resilience/reliable-and-resilient-cloud-topology-practices1.html).

## **_Security_**

The Oracle Enterprise Landing Zone follows best practices for security design principles.

- Design for attackers
  - Limit permissions based on requirements
  - Enforce network segmentation
- Leverage native controls
- Use identity as primary access control
- Accountability
- Embrace automation
- Focus on information protection
- Design for resilience
  - Ongoing vigilance
  - Defense in depth
  - Defense at edge
  - Least privilege
- Assume zero trust

For more information, see the security design principles in [Best practices framework for Oracle Cloud Infrastructure](https://docs.oracle.com/en/solutions/oci-best-practices/effective-strategies-security-and-compliance1.html#GUID-68F2BA09-96CE-48A4-B92E-8F928EE86F13).

# **Architecture Overview**

The OELZv2 creates an architectural framework that's ready for you to launch new projects and workloads on OCI.

- [Compartments](https://docs.oracle.com/en-us/iaas/Content/cloud-adoption-framework/landing-zone.htm#compartments): Use compartments to organize and isolate your resources to make it easier to manage and secure access to them.
- [Tags](https://docs.oracle.com/en-us/iaas/Content/cloud-adoption-framework/landing-zone.htm#tags): Use tags to organize and list resources based on your business needs.
- [Budgets and alerts](https://docs.oracle.com/en-us/iaas/Content/cloud-adoption-framework/landing-zone.htm#budgets-alerts): Use [budgets](https://docs.oracle.com/iaas/Content/Billing/Concepts/budgetsoverview.htm) to set soft limits on your OCI spending, and use alerts to let you know when you might exceed your budget.
- [Oracle Cloud Infrastructure Identity and Access Management (IAM)](https://docs.oracle.com/en-us/iaas/Content/cloud-adoption-framework/landing-zone.htm#iam): Use IAM to control access to your cloud resources on OCI.
- [Networking and connectivity](https://docs.oracle.com/en-us/iaas/Content/cloud-adoption-framework/landing-zone.htm#networking-connectivity): Create a virtual cloud network (VCN), subnets, and other networking and connectivity resources that are required to run your workloads and connect to the internet or your on-premises network.
- [Security](https://docs.oracle.com/en-us/iaas/Content/cloud-adoption-framework/landing-zone.htm#security): Enable a strong security posture by enabling OCI security services such as Oracle Cloud Guard, Oracle Vulnerability Scanning Service, and Oracle Cloud Infrastructure Bastion.

The following diagram illustrates the OELZv2.0 reference architecture.

![](./images/enterprise-landing-zone-v2.svg)

## **_Network and Connectivity_**

One of the key components of the Oracle Enterprise Landing Zone v2.0 (OELZ v2.0) is the network architecture and its segmentation. With the adoption of the OELZ v2.0, you can have a highly segregated, functional environment to securely deploy your workloads. One of the key components of the network architecture is the use of the Hub & Spoke architecture the OELZ v2.0 will provide two distinct Hub & Spoke architectures (one for the Production environment and one for non-Production environments) that are segregated from each other.

In Oracle Cloud Infrastructure (OCI), the [Hub & Spoke architecture](https://docs.oracle.com/en/solutions/hub-spoke-network-drg/index.html#GUID-FB5990CB-A23B-482D-80F4-AE4A548DEC9C) is a network design pattern in which a central hub network is connected to multiple spoke networks. The hub network is typically used for shared resources, such as security appliances and core services, while the spoke networks are used for individual workloads or applications.

The Hub & Spoke architecture deployed within the OELZ  can provide several benefits, including:

1. Isolation: Each spoke is its own compartment, which provides an additional layer of isolation and security for resources. This allows for better management and control over access to resources and limits the blast radius of any security incident.
2. Scalability: Spokes can be added or removed as needed to support different use cases or teams. This allows for a flexible and scalable architecture that can adapt to changing business needs.
3. Networking: A hub provides a central point for all network traffic to flow through, which simplifies the overall network architecture and improves security. Resources in different spokes can communicate with each other over the hub-spoke network without having to traverse the internet.
4. Resource Management: Each spoke can be managed and administered independently, which allows for better resource allocation and more efficient use of resources. It also allows for different teams or business units to manage their own resources, with the ability to have different access to control and management.
5. Cost Optimization: By centralizing certain resources, like VPN gateways and load balancers, in the hub, it can be more cost-effective to manage them.
6. Governance: By having a central hub it becomes much more easier to apply governance rules and policies across the whole infrastructure and have a clear view of all the resources and activity going on in your enterprise.

It's important to notice that this architecture is really flexible, so some of the components in the hub, like load balancer, could be moved to the Spoke, depending on the use case or need.

In OELZ v2.0 OCI, the hub network is created using a Virtual Cloud Network (VCN) in the Network Shared Infrastructure compartment in each environment, and the spoke networks are created in each Application compartment, using VCN Attachment through a [Dynamic Routing Gateway (DRG)](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingDRGs.htm). This allows the spoke networks to access the shared resources in the hub network while maintaining their isolation from each other.

Overall, the Hub & Spoke architecture is a flexible and scalable design pattern that can be used to build complex network architectures in OCI and this is one of the main reasons why OELZ v2.0 will allow you to have a pre-configured environment ready to use within minutes.

For more information on the network architecture components, please refer to the sections of the modules that compose it.

## **_Logging and Monitoring_**

Two other key components of the OELZ are the monitoring and logging of the resources that will be part of it. These two areas are particularly important within the IT Governance and Operations of each enterprise.

[Monitoring](https://docs.oracle.com/en-us/iaas/Content/Monitoring/Concepts/monitoringoverview.htm) and [logging](https://docs.oracle.com/en-us/iaas/Content/Logging/Concepts/loggingoverview.htm) are important in the OELZ v2.0 because they help you to understand the performance and availability of your cloud resources and applications. They can also help you to identify and troubleshoot issues and maintain compliance with regulatory requirements.

By monitoring your resources, you can ensure that they are performing as expected and that they have sufficient capacity to meet the demands of your applications. This can help you optimize your cloud environment's performance and cost efficiency.

Logging lets you record events and activities in your cloud environment. This can be useful for a variety of purposes, such as auditing, debugging, and analysing trends.

Overall, monitoring and logging are critical for the operation, maintenance, and security of your OCI cloud environment.

For more information on the monitoring and logging components, please refer to the sections of the modules that compose them.

## **_Multi environment_**

In order to support multiple environments, the landing zone deploys two isolated environments:

- Production Environment for your production workloads
- Non-production environment for your development or other workloads.

Both of these environments are isolated from each other in different ways:

- Each environment has a separate identity domain, so users are isolated on a single environment and non-production users won't have access to production resources.
- Each environment has its own hub and spoke network.
- Each environment has its own Cloud Guard target
- Each environment has a separate logging and monitoring configuration

This separation of environments allows you to secure deploy production workloads and non-production workloads without having to worry about resources being able to access resources from a different environment.

In addition to the two default environments, the Environments module allows you to deploy additional environments if you require one. These additional environments will have the same isolation to the other environment as described above.

## **_Identity_**

Use Oracle Cloud Infrastructure Identity and Access Management (IAM) to control access to your cloud resources on OCI.

The Landing Zone creates IAM groups and policies that control access to the resources created by the Landing Zone. Optionally, you can federate with your organization's Microsoft Active Directory implementation.

We recommend that you create one or more [break-glass users](https://docs.oracle.com/en-us/iaas/Content/cloud-adoption-framework/deploy-landing-zone.htm#emergency-access-accounts) during your deployment, especially if you are using federation. Break-glass users are administrators who have emergency access to all Oracle Cloud Infrastructure services and resources in the tenancy.

**Federating with Microsoft Active Directory**

With the OELZv2, you can optionally federate with Microsoft Active Directory.

Use the same group names in Oracle Cloud Infrastructure as you use for Active Directory. To do this, pass the Active Directory group names as variables to the OELZv2 Terraform module. The groups will be created by the landing zone and mapped to your Active Directory groups.

For more information about federating with Active Directory, see [Federating with Microsoft Active Directory](https://docs.oracle.com/iaas/Content/Identity/Tasks/federatingADFS.htm).

## _Compliance_

OELZv2 includes a set of pre-built policies and guardrails that help ensure that your OCI environment has a strong security foundation to help your organization achieve your security compliance goals.  The security controls that have been implemented in OELZv2 include recommendations that help our customers attain [CIS 1.2](https://www.cisecurity.org/benchmark/oracle_cloud) compliance Level 1.

The Center for Internet Security, Inc. (CIS®) is a community-driven non-profit, responsible for the CIS Controls® and CIS Benchmarks™, globally recognized best practices for securing IT systems and data. The goal of CIS is to prevent and mitigate new cyber threats that are identified in the industry today. For many OCI customers, this has been a go-to benchmark that guides their architecture to help them secure their workloads in Oracle Cloud Infrastructure (OCI).  Recognizing the importance of adhering to best practice guidance from both OCI teams and the industry, OCI Landing Zones continues to implement support for CIS Benchmarks today.

For more information, please refer to ["CIS 1.2 Level 1"](./images/CIS1.2Level1.xlsx) for a list of security controls that are included in OELZv2.

# **Functional Modules**

The OELZ is comprised out of different functional modules. Each of these modules is a set of terraform scripts that groups a functional area of the landing zone.
 These modules have been designed so they can be customized and run independently. This makes the OELZv2 more flexible and allows the customers to tweak it to their needs.

Below is a detailed description of the different modules

## **OELZ _Landing Zone Module_**

The Landing Zone Module is the module that brings everything together. It creates the entire Landing Zone by invoking the other modules.
 The OELZv2 deploys two isolated environments as depicted on the diagram above.
 This module invokes the environment module twice, each for a distinct isolated environment:

- Environment Module to create the production environment
- Environment Module to create the non-Production environment

This module is also responsible for creating the Landing Zone parent compartment but apart from that, it doesn't deploy any other resources and relies on the environment module for the deployment of an environment.

## **_Environment Module_**

The Environment Module is a module that aggregates the other modules into a single environment. It uses the following modules to compose an isolated environment in the Landing Zone:

- Compartment Module
- Budget and Tagging Module
- Identity Module
- Network Module
- Security Module
- Monitoring Module
- Logging Module

The module in its own doesn't create any additional resources. It only aggregates the other functional modules.

## **_Budgets and Tagging Module_**

Budget & Tagging are another two key components to achieve strong Governance within the OELZ v2.0.

Budgeting and tagging are important in the Oracle Cloud Infrastructure (OCI) OELZ v2.0 because they help you to manage and optimize the cost of your cloud resources.

Budgeting allows you to set limits on your cloud spending, and to receive notifications when your usage approaches or exceeds those limits. This can help you to avoid unexpected charges and to better control your cloud costs.

Tagging allows you to assign metadata to your cloud resources, such as tags that represent the purpose, owner, or environment of those resources. You can then use tags to organize and manage your resources and to track your cloud costs by tag. For example, you might use tags to track the costs of different projects or departments or to identify resources that are eligible for discounts or credits.

Overall, budgeting and tagging can help you to better understand your cloud usage and costs and to manage your resources more effectively in OCI.

The customer will have the opportunity during deployment to enable or disable Budget and Tag for each environment. For more information about the Tagging Best Practice please refer to [Best Practices for Using Tags to Manage Costs, Operations, and Governance (oracle.com)](https://blogs.oracle.com/cloud-infrastructure/post/best-practices-for-using-tags-to-manage-costs-operations-and-governance) and [FinOps best practices for Oracle Cloud Infrastructure | CloudWorld 2022 - YouTube](https://www.youtube.com/watch?v=0ia5wMwrAuI).

The main components that the Budget module will have been as follows:

- 1 Budget per environment [Optional]
  - If feature is enable - Budget scope: **L2- Environment compartment**

The main components that the Tagging module will have been as follows:

- 1 Tag namespace per environment [Optional] create in **L2- Environment compartment**
  - If feature is enabled:
    - Tag Environment
    - Tag Cost Center
    - Tag Geo Location

## **_Compartments Module_**

You use compartments to organize and isolate your resources to make it easier to manage and secure access to them.

The OELZv2 creates a compartment structure for your organization. You control access to compartment by creating policies that specify what actions groups of users can take on the resources in those compartments. The following diagram shows the compartment structure that is created by the landing zone:

![](./images/Compartment.png)

The compartments module only creates the compartment structure for a single environment which include the following compartments:

- **L2 - Environment:** The encapsulating compartment for an environment
- **L3 - Shared infrastructure** : compartment containing the shared infrastructure:
  - **L4: Network** : The compartment that will hold the Hub component of the network
  - **L4 Security** : The compartment holding the security and identity components
- **L3 - Workload** compartment that will hold a spoke connecting to the hub
- **L3 Logging** : Compartment that will hold a bucket to store the log files from the environment
- **L3 Backup** : A backup compartment that will contain the configuration and state file

## **_Identity Module_**

The identity module creates and configures an identity domain in an environment in the landing zone.

In order to isolate access between resources, groups are created together with policies in order to restrict access to certain resources.

- **Network Admin: ** User group that have access to the network resources inside your environment
- **SecOps Admin: ** User group that have access to the security related resources inside your environment
- **Identity Admin: ** User group that can manage the identity related resources
- **Platform Admin: ** User group that have access to usage reports and can manage budgets
- **Ops Admin: ** User group that have access to the metrics, events and alerts in your environment
- **Log Admin: ** User group that have access to the logs of your environment


Our admin groups are not a 1:1 mapping to the [IDCS Admin groups](https://docs.oracle.com/en/cloud/paas/identity-cloud/uaids/understand-administrator-roles.html). But some admin groups provide the same IDCS functionality. 

| **OELZ Admin** | **IDCS Admin** |
| --- | --- |
|Identity Admin|Identity domain administrator, User administrator, User Manager|
|SecOps Admin|Security administrator|


## **_Logging Module_**

The Logging Module implemented by OELZv2 will use the below services to help your organization meet your Security Policy and Compliance requirements.

- Vault (Key Management)
- Log Archiving Storage Bucket
- Default Log Group
- Streams & Events
- Service Connector

**Log Archiving Storage Bucket (optional)**

An optional immutable storage bucket will be deployed by default for the purposes of archiving logs and events within the defined retention period according to user input.  The OELZv2 is deployed with a 1 day retention duration to facilitate environment clean up and this should be revised accordingly to comply with the retention requirements of your organization's security policies.

**Default Log Group**

OCI generates service logs for supported services and accordingly, users can enable or disable logging for each supported service.  TheOELZ default setting is to enable and store all service logs.  For more information regarding [Service Logs](https://docs.oracle.com/en-us/iaas/Content/Logging/Concepts/service_logs.htm).

**Streams & Events**

OCI Streaming service is used for real-time ingestion of high-volume data streams.  It can be used where data is continually produced and published sequentially such as with log events.  The OELZv2 will utilize the OCI Streaming Service in conjunction with OCI events.   OCI services generate _events_ that provide notifications when there are any resource changes in your environment.

Please refer to [Services Event Types](https://docs.oracle.com/en-us/iaas/Content/Events/Reference/eventsproducers.htm#Services_that_Produce_Events) for a full list and refer to these links for more information regarding [Streaming](https://docs.oracle.com/en-us/iaas/Content/Streaming/home.htm) and [Events](https://docs.oracle.com/en-us/iaas/Content/Events/home.htm).

**Service Connector Hub**

Many organizations' security policies will stipulate a common archiving system should be made available for the purposes of storing systems, applications, security, and event logging.  The Service Connector service will be used to ship all audit logs, service logs, and service events to object storage so that it can be made available for operational review.

For more details regarding [Service Connector Hub](https://docs.oracle.com/en-us/iaas/Content/service-connector-hub/archivelogs.htm#Scenario_Archive_Log)

## **_Monitoring Module_**

The following module will allow the customer to be able to monitor their resources and receive the correct alerts in case of malfunctioning OELZ v2.0 components/ OCI tenancy.

It provides a starting point that administrators can tweak according to their operational model.

Services inside OCI provide metrics and events that can be monitored through the metrics dashboard. In addition to this, alerts can be created based on certain queries of these metrics and events. To organize these alerts, topics are created that will group certain alerts. In the landing zone, these topics are defined per the severity of the alert (critical and warning). Different topics are also created per compartment and environment (ex, PRD-Network, NPRD-Security and PRD-workload, etc.). Please refer to the next sub-paragraph for a detailed overview of these topics.
 Each of these topics will have different monitoring rules assigned to them for each environment.

To avoid excessive costs and a lot of messages, the OELZ v2.0 deployment will have all these alerts disabled by default. Based on your operational model, you can enable the relevant alerts from the OCI console.

The monitoring structure contains following elements:

- Monitor Alert Channels - Create Notification Topics (e.g. PRD-Network-Critical, NPRD-Security-Warning) and subscription (i.e. email)
- Monitor OCI service incidents and action required from OCI maintenance by subscribing to Console Announcements
- Monitor Cloud Guard status (e.g. problemthresholdreached) by subscribing Cloud Guard events
- Monitor VSS and Cloud Guard detected problem by subscribing Cloud Guard events
- Enable metrics-based monitoring of Network, Security, Logging and Workload compartments by creating sample alarm rules for the deployed service metrics namespaces

Enable Logging Analytics for reporting via Log Explorer and Dashboards

- Enable Logging Analytics at tenancy level
- Ingest logs (i.e. Default Log Group and Audit Logs) into Log Analytics via service connectors

![](./images/Monitoring.png)

  **Operational Model**

In order to organize alerts in meaningful groups, multiple alerts are grouped together for a compartment admin to subscribe to.

- Workload X admin of a specific environment: receives alerts for the specific workload.
- Security admin of a specific environment: receives alerts for all resources in the Security compartment (Bastion, VSS, ... ) as well as security related notifications from Cloud Guard.
- Network admin of a specific environment: receives alerts for all resources in the Network compartment (Network HUB, DRG, Fast Connect).
- Identity admin of a specific environment: receives alerts related IAM
- Platform admin of a specific environment: receives alerts related Budgets

In addition to this, messages are grouped into [Notification Topics](https://docs.oracle.com/en-us/iaas/Content/Notification/Tasks/managingtopicsandsubscriptions.htm) per severity (Critical and Warning) for each environment and compartment (Network, Security and Workload).

| **#** | [**compartment\_id**](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/ons_notification_topic#compartment_id) | **name** |
| --- | --- | --- |
| 1 | \<L4 - Network Compartment ID\> | PRD-Network-Critical and NPRD-Network-Critical |
| 2 | \<L4 - Network Compartment ID\> | PRD-Network-Warning and NPRD-Network-Warning |
| 3 | \<L4 - Security Compartment ID\> | PRD-Security-Critical and NPRD-Security-Critical |
| 4 | \<L4 - Security Compartment ID\> | PRD-Security-Warning and PRD-Security-Warning |
| 5 | \< L3 -Workload X Compartment ID\> | \<Workload\>-Critical [part of Workload Expansion Module] |
| 6 | \< L3 -Workload X Compartment ID\> | \<Workload\>-Warning [part of Workload Expansion Module] |
| 7 | \<L2 - \<Environment Name\> | PRD-Budget-Warning and NPRD-Budget-Warning |
| 8 | \<L2 - \<Environment Name\> | PRD-IAM-Warning and NPRD-IAM-Warning |

Admins of each compartment are able to subscribe to these topics so they will receive an email when an alert occurs. By default, a single E-Mail address will be used for all alert groups, however it is possible to overwrite these values in the console so each notification topic can be send to a different E-Mail address.

**Monitoring Rules**

The OELZ v2.0 will create many monitoring rules that can trigger alerts. These are disabled by default. You can enable the rules that apply to your operational needs from the OCI Console.

For a complete list of events/alerts refer to the **OELZ v2.0 Deployment guide/ User Guide.**

## **_Network Module_**

The network module includes two main Functional Modules, the first will deploy a type of network called "Hub & Spoke" (H&P) that will allow the various workloads to interconnect with each other. The second one called "Network Extension Module" will extend connectivity with the on-premises network as well using the H&P created previously.
By default, the OELZ v2.0 will deploy the H&P module within the " **L2 - OCI-ELZ-\<Environment Name\>**" compartment (for **PROD** and **NO-PROD** ). Also, the Network Extension Module will be an optional module and it will only be allowed to be deployed in the production environment. As a result, it will be shared between the two environments prod and non-prod.

The main components that the Hub module will have been as follows:

- A **VCN** which will host the different subnets of the HUB deployed in the **L4 - Network compartment**
- A **public subnet** to host all internet-facing servers and resources, including load balancers, Web Servers...This subnet must be secured with the correct Cloud Guard recipes and other security features, as described in [Security paragraph](#ArchitecturalGuide-security)[.](#ArchitecturalGuide-securitymodule)
- A **private subnet** to host all common or shared services that your environment uses such as Network Virtual Appliance, Internal Jump Box Server.
- A **DRG** which will enable routing between the VNC Hub and other application VCNs (spokes), deployed in the **L4 - Network compartment**
- A **Internet Gateways** [Optional] which allows traffic between the public subnets in a VCN and the public internet, deployed in the **L4 - Network compartment**
- A **NAT Gateways** [Optional] which enables private resources in a VCN to access hosts on the internet, without exposing those resources to incoming internet connections, deployed in the **L4 - Network compartment**
- A **Service gateway** [Optional] which provides access from a VCN to other services, such as Oracle Cloud Infrastructure Object Storage. The traffic from the VCN to the Oracle service travels over the Oracle network fabric and never traverses the internet, deployed in the **L4 - Network compartment.**

The main components that the Spoke module will have are as follows:

- A **VCN** which will host the different subnets of the Spoke deployed in the **L3 - Workload compartment**
- Three **private subnets** to host all components of your application using different tier such as Web, App and DB.
- A **VCN Attachments** which will be connected to the DRG of the HUB.
- A **NAT Gateways** [Optional] which enables private resources in a VCN to access hosts on the internet, without exposing those resources to incoming internet connections, deployed in the **L3 - Workload compartment**
- A **Service gateway** [Optional] which provides access from a VCN to other services, such as Oracle Cloud Infrastructure Object Storage. The traffic from the VCN to the Oracle service travels over the Oracle network fabric and never traverses the internet, deployed in the **L3 - Workload compartment.**

**NOTE :** In a scenario in which the customer wishes to publish its Web Servers using the OELZ v2.0, an Public Load Balancer must be deployed within the public subnet in the HUB ( **L4 - Network Compartment** ), which will have as endpoints the Web Servers present in the subnet that will be part of the **L3 - Workload compartment.** Since connectivity is already configured via the Hub & Spoke architecture, all that needs to be done is to change the Security Lists associated with the subnets to enable traffic between the Load Balancer and the endpoints.

The Network extension module consists of two sub-modules that will allow the customer to decide whether to deploy a Site-to-Site VPN in each environment rather than share Fast Connect between environments.

The main components that the VPN module will have are as follows:

- A **Customer Premises Equipment (CPE)** deployed in the **L4 - Network compartment** ,  so traffic can flow between your on-premises network and virtual cloud network (VCN).
- An  **IPsec Connection.**

See these related topics:

-
  - [Networking](https://docs.oracle.com/en-us/iaas/Content/Network/Concepts/landing.htm#top): For general information about the parts of a VCN
  - [Site-to-Site VPN](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingIPsec.htm#VPN_Connect): For various topics about IPsec VPNs
  - [Verified CPE Devices](https://docs.oracle.com/en-us/iaas/Content/Network/Reference/CPElist.htm#Verified_CPE_Devices): For a list of CPE devices Oracle has verified.

Using this module, you can decide during deployment to create a Site-to-Site VPN for each environment so that you can continue to have segregated traffic

The main components that the Fast Connect module will have been as follows:

- A **Fast Connect circuit** dedicated, private connection between your data center and Oracle Cloud Infrastructure, using your choice of Oracle partners deployed in the **L4 - Network compartment **
- A **Remote Peering Connections (RPC) attachment** which will peer the DRGs of the two environments created during the OELZ v2.0 deployment.

Using this module, the customer can decide whether or not to deploy a Fast Connect circuit by sharing it between environments. This decision was made because the Fast Connect service is generally more expensive than a Site-to-Site VPN.

After deployment, if it is necessary to have other Fast Connect circuits, the customer will be able to create more but will have to change the Route Table set during deployment. While enabling this module, environments will continue to be segregated as traffic will be allowed or denied by the security lists applied to each subnet.

. While enabling this module, environments will continue to be segregated as traffic will be allowed or denied by the security lists applied to each subnet.

The security lists implemented during the OELZ v2.0 deployment are CIS 1.2.0 compliant, so all incoming traffic will be blocked except the ICMP protocol. For more information please refer to the CIS Benchmark 1.2.0 for Oracle Cloud Infrastructure: [CIS Oracle Cloud Infrastructure Benchmarks (cisecurity.org)](https://www.cisecurity.org/benchmark/oracle_cloud)

## **_Security Module_**

Oracle Cloud Infrastructure (OCI) is a Security-first Cloud Service that helps organizations reduce the risk of security threats for cloud workloads by putting our customers' Data Security and Privacy first.  This is achieved via the automation of security operations with simple, prescriptive, and integrated cloud-native security capabilities built into the OCI platform.  Oracle helps customers easily adopt OIC services and secure their cloud infrastructure, data, and applications.

The OELZv2 further supports Oracle's Security-First Cloud strategy tenets:

- Security should be simple—easy to use, deploy, and operate
- Security tools should offer guidance to help customers achieve strong security more easily
- Security should be integrated and automated, reducing manual security tasks and human errors
- Cloud security should be economically attractive, improving the cost of securing cloud workloads

The following OCI cloud-native services will be implemented by OELZv2 to help your organization meet your Security Policy and Compliance requirements.

- Cloud Guard
- Vulnerability Scanning Service (VSS)
- Vault (Key Management)
- Bastion

**Cloud Guard**

Cloud Guard is the OCI native security service that helps our customers monitor, identify threats/configuration issues, achieve a strong security posture and maintain compliance with their security policies.  When issues are detected, Cloud Guard can recommend, assist or execute corrective actions based on how you configure Cloud Guard to respond.  The OELZv2 will enable Cloud Guard services by default, and it will use your organization's tenancy home region as its reporting region.  Cloud Guard is used in conjunction with VSS detector recipes.  The following default Oracle Managed Detector Recipes will be enabled to provide a strong secure baseline for your organization's OCI environment:

- Configuration Detector Recipe - Set of rules designed specifically to detect resource configuration settings that could pose a security problem.
- Threat Detector Recipe - Set of rules designed to specifically to detect rogue user activity and high-risk activity based on our Threat Intelligence Service.
- Activity Detector Recipe - Set of rules designed specifically to detect actions on resources that could pose a security problem

These recipes can be used as the default Oracle-managed versions, or you can clone these recipes and use them to provide a strong baseline and further customize the recipes based on your requirements.

It is not recommended to enable the Responder Recipe due to changes made during pre-production activities.  The Responder Recipe should be enabled after completing a thorough review and testing.

- Responder Recipe - Defines the action or set of actions to take in response to a problem that a detector has identified.

If required, Cloud Guard findings can be pushed to 3rd Party SIEM, e.g. [Splunk HTTP Event Collector (HEC) via OCI SDK](https://blogs.oracle.com/cloudsecurity/post/push-cloud-guard-findings-to-splunk-hec).

For more details, please refer to the official [OCI Cloud Guard documentation](https://docs.oracle.com/en-us/iaas/cloud-guard/home.htm).

**Vulnerability Scanning Service (VSS)**

OCI Vulnerability Scanning Service (VSS) can be scheduled to check hosts, detect open ports and container images for vulnerabilities.  The default Oracle Detector Recipes will be used for scanning compute resources and the public port.  These default recipes provide a foundational security posture baseline based on Oracle and industry security best practices.

Please note that the Oracle Vulnerability Scanning Service is not compliant with PCI DSS requirements.  OCI supports the use of Qualys agents which can be integrated with OCI VSS.

For additional detail, please refer to our [Vulnerability Scanning Service (VSS)](https://docs.oracle.com/en-us/iaas/scanning/home.htm) documentation.

**Vault (Key Management)**

OCI Vault is our cloud-native encryption management service that will be used in this Landing Zone to store and manage Master Encryption Keys and Secrets that are used to secure your OCI resources and will be used to encrypt your logs.  This OELZv2 landing zone will default to VIRTUAL.   A Master Encryption Key (MEK) AES 256 will be generated by default as part of your Landing Zone deployment.  This MEK will be used to encrypt your log object storage buckets.  Customers can choose to "bring your own key" (BYOK) and import key material from your on-premises or 3rd-party cloud environments.  In addition, OCI can provide a Hardware Security Module (HSM) dedicated vault service as an option.

Please refer to [Vault (Key Management)](https://docs.oracle.com/en-us/iaas/Content/KeyManagement/Concepts/keyoverview.htm) for more details.

**Bastion**

OCI Bastions provides restricted and time-limited access to target resources that don't have public endpoints, letting authorized users connect from specific IP addresses to target resources using Secure Shell (SSH) sessions.  This Landing Zone deployment will also include the OCI Bastion service which allows privileged users to connect from specified IP Addresses to target resources over Secure Shell (SSH).   When connected via Bastion, users can interact with the target OCI resource by using any software or protocol supported by SSH. For example, you can use the Remote Desktop Protocol (RDP) to connect to a Windows host or use Oracle Net Services to connect to a database.  The Bastion Service is associated with a single VCN and there is a limit of 5 Bastions per region.

For more information, please see [OCI Bastion](https://docs.oracle.com/en-us/iaas/Content/Bastion/Concepts/bastionoverview.htm).

## **_Workload Module_**
The workload expansion module is responsible for deploying the resources for an empty workload. It will deploy following resources:
* Compartment
* Network (Spoke)
* Logging
* Monitoring
* Policies and workload group

**Compartment**

One workload compartment would be created in the L3 - Workload compartment.

**Network (Spoke)**

The main components that the Spoke module will have are as follows:

- A **VCN** which will host the different subnets of the Spoke deployed in the **L3 - Workload compartment**
- Three **private subnets** to host all components of your application using different tier such as Web, App and DB.
- A **VCN Attachments** which will be connected to the DRG of the HUB.
- A **NAT Gateways** [Optional] which enables private resources in a VCN to access hosts on the internet, without exposing those resources to incoming internet connections, deployed in the **L3 - Workload compartment**
- A **Service gateway** [Optional] which provides access from a VCN to other services, such as Oracle Cloud Infrastructure Object Storage. The traffic from the VCN to the Oracle service travels over the Oracle network fabric and never traverses the internet, deployed in the **L3 - Workload compartment.**

**Logging**

The Logging service would be applied in the Landing Zone Home compartment level. Therefore, all the logs from
Workload Expansion would also be captured.

**Monitoring**

Same as the default workload, the monitoring structure contains following elements:

- Monitor Alert Channels - Create Notification Topics (Workload-Critical, Workload-Warning) and subscription (i.e. email)
- Monitor OCI service incidents and action required from OCI maintenance by subscribing to Console Announcements
- Monitor Cloud Guard status (e.g. problemthresholdreached) by subscribing Cloud Guard events
- Monitor VSS and Cloud Guard detected problem by subscribing Cloud Guard events
- Enable metrics-based monitoring of Network, Security, Logging and Workload compartments by creating sample alarm rules for the deployed service metrics namespaces

**Policies and workload group**

Three admin groups are created in the workload expansion:
- workload admin group: User group that have access to the workload related resources inside your environment
- application admin group: User group that have access to the application (volume family, object, file, instance, etc) resources inside your environment
- database admin group: User group that have access to the database resources inside your environment