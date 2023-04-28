# Oracle Enterprise Landing Zone Architectural Guide

# **Introduction**

The Oracle Enterprise Landing Zone "OELZ" provides the baseline architectural framework for your organization to deploy new projects and workloads on OCI. The landing zone consists of Terraform modules, the architectural documentation, and an implementation guide. The landing zone helps you quickly and securely create a foundation for your cloud deployment based on Oracle recommendations, customer experience, and industry-standard best practices.

OELZ is a set of Terraform modules that are designed to make it easy to set up a secure and compliant multi-account infrastructure on OCI. Some common use cases for OCI Oracle Enterprise Landing Zone include:

- Governance and compliance: The OELZ provides a set of pre-built policies and guardrails that help ensure that your OCI environment is compliant with industry standards, such as ISO27001 and PCI DSS (these and other compliance standards will be part of ongoing releases).
- Automation and scalability: The Landing Zone can be used to automate the creation of new accounts, users, and resources on OCI, making it easy to scale your infrastructure as your organization grows.

# **Primary Objectives**

The primary objectives of the OELZ zone include the following items:

- Reduce time-to-start and deploy.
- Provide an architecturally strong foundation.
- Maintain the flexibility to customize and evolve the implementation to your organization's needs.

# **Key Design Principles**

Key design principles for resiliency and security ensure that the OELZ zone deploys a strong foundation for your cloud environment.

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

The OELZ creates an architectural framework that's ready for you to launch new projects and workloads on OCI.

- [Compartments](https://docs.oracle.com/en-us/iaas/Content/cloud-adoption-framework/landing-zone.htm#compartments): Use compartments to organize and isolate your resources to make it easier to manage and secure access to them.
- [Tags](https://docs.oracle.com/en-us/iaas/Content/cloud-adoption-framework/landing-zone.htm#tags): Use tags to organize and list resources based on your business needs.
- [Budgets and alerts](https://docs.oracle.com/en-us/iaas/Content/cloud-adoption-framework/landing-zone.htm#budgets-alerts): Use [budgets](https://docs.oracle.com/iaas/Content/Billing/Concepts/budgetsoverview.htm) to set soft limits on your OCI spending.
- [Oracle Cloud Infrastructure Identity and Access Management (IAM)](https://docs.oracle.com/en-us/iaas/Content/cloud-adoption-framework/landing-zone.htm#iam): Use IAM to control access to your cloud resources on OCI.
- [Networking and connectivity](https://docs.oracle.com/en-us/iaas/Content/cloud-adoption-framework/landing-zone.htm#networking-connectivity): Create a virtual cloud network (VCN), subnets, and other networking and connectivity resources that are required to run your workloads and connect to the internet or your on-premises network via service gateway.
- [Security](https://docs.oracle.com/en-us/iaas/Content/cloud-adoption-framework/landing-zone.htm#security): Enable a strong security posture by enabling OCI security services such as Oracle Cloud Infrastructure Bastion.

The following diagram illustrates the OELZ.0 reference architecture.

![](./images/enterprise-landing-zone-v2.svg)

## **_Network and Connectivity_**

One of the key components of the OELZ is the network architecture and its segmentation. With the adoption of the OELZ , you can have a highly segregated, functional environment to securely deploy your workloads. One of the key components of the network architecture is the use of the Hub & Spoke architecture the OELZ  will provide two distinct Hub & Spoke architectures (one for the Production environment and one for non-Production environments) that are segregated from each other.

In Oracle Cloud Infrastructure (OCI), the [Hub & Spoke architecture](https://docs.oracle.com/en/solutions/hub-spoke-network-drg/index.html#GUID-FB5990CB-A23B-482D-80F4-AE4A548DEC9C) is a network design pattern in which a central hub network is connected to multiple spoke networks. The hub network is typically used for shared resources, such as security appliances and core services, while the spoke networks are used for individual workloads or applications.

The Hub & Spoke architecture deployed within the OELZ  can provide several benefits, including:

1. Isolation: Each spoke is its own compartment, which provides an additional layer of isolation and security for resources. This allows for better management and control over access to resources and limits the blast radius of any security incident.
2. Scalability: Spokes can be added or removed as needed to support different use cases or teams. This allows for a flexible and scalable architecture that can adapt to changing business needs.
3. Networking: A hub provides a central point for all network traffic to flow through, which simplifies the overall network architecture and improves security. Resources in different spokes can communicate with each other over the hub-spoke network without having to traverse the internet.
4. Resource Management: Each spoke can be managed and administered independently, which allows for better resource allocation and more efficient use of resources. It also allows for different teams or business units to manage their own resources, with the ability to have different access to control and management.
5. Cost Optimization: By centralizing certain resources, like VPN gateways and load balancers, in the hub, it can be more cost-effective to manage them.
6. Governance: By having a central hub it becomes much more easier to apply governance rules and policies across the whole infrastructure and have a clear view of all the resources and activity going on in your enterprise.

It's important to notice that this architecture is really flexible, so some of the components in the hub, like load balancer, could be moved to the Spoke, depending on the use case or need.

In OELZ  OCI, the hub network is created using a Virtual Cloud Network (VCN) in the Network Shared Infrastructure compartment in each environment, and the spoke networks are created in each Application compartment, using VCN Attachment through a [Dynamic Routing Gateway (DRG)](https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/managingDRGs.htm). This allows the spoke networks to access the shared resources in the hub network while maintaining their isolation from each other.

Overall, the Hub & Spoke architecture is a flexible and scalable design pattern that can be used to build complex network architectures in OCI and this is one of the main reasons why OELZ  will allow you to have a pre-configured environment ready to use within minutes.

For more information on the network architecture components, please refer to the sections of the modules that compose it.

## **_Identity_**

Use Oracle Cloud Infrastructure Identity and Access Management (IAM) to control access to your cloud resources on OCI.

The Landing Zone creates IAM groups and policies that control access to the resources created by the Landing Zone. Optionally, you can federate with your organization's Microsoft Active Directory implementation.

## _Compliance_

OELZ includes a set of pre-built policies and guardrails that help ensure that your OCI environment has a strong security foundation to help your organization achieve your security compliance goals.  The security controls that have been implemented in OELZ include recommendations that help our customers attain [CIS 1.2](https://www.cisecurity.org/benchmark/oracle_cloud) compliance Level 1.

The Center for Internet Security, Inc. (CIS®) is a community-driven non-profit, responsible for the CIS Controls® and CIS Benchmarks™, globally recognized best practices for securing IT systems and data. The goal of CIS is to prevent and mitigate new cyber threats that are identified in the industry today. For many OCI customers, this has been a go-to benchmark that guides their architecture to help them secure their workloads in Oracle Cloud Infrastructure (OCI).  Recognizing the importance of adhering to best practice guidance from both OCI teams and the industry, OCI Landing Zones continues to implement support for CIS Benchmarks today.

For more information, please refer to ["CIS 1.2 Level 1"](./images/CIS1.2Level1.xlsx) for a list of security controls that are included in OELZ.

## **_Compartments Module_**

You use compartments to organize and isolate your resources to make it easier to manage and secure access to them.

The OELZ creates a compartment structure for your organization. You control access to compartment by creating policies that specify what actions groups of users can take on the resources in those compartments. The following diagram shows the compartment structure that is created by the landing zone:

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


**Streams & Events**

OCI Streaming service is used for real-time ingestion of high-volume data streams.  It can be used where data is continually produced and published sequentially such as with log events.  The OELZ will utilize the OCI Streaming Service in conjunction with OCI events.   OCI services generate _events_ that provide notifications when there are any resource changes in your environment.

Please refer to [Services Event Types](https://docs.oracle.com/en-us/iaas/Content/Events/Reference/eventsproducers.htm#Services_that_Produce_Events) for a full list and refer to these links for more information regarding [Streaming](https://docs.oracle.com/en-us/iaas/Content/Streaming/home.htm) and [Events](https://docs.oracle.com/en-us/iaas/Content/Events/home.htm).


## **_Network Module_**

The network module includes two main Functional Modules, the first will deploy a type of network called "Hub & Spoke" (H&P) that will allow the various workloads to interconnect with each other. The second one called "Network Extension Module" will extend connectivity with the on-premises network as well using the H&P created previously.
By default, the OELZ  will deploy the H&P module within the " **L2 - OCI-ELZ-\<Environment Name\>**" compartment (for **PROD** and **NO-PROD** ). Also, the Network Extension Module will be an optional module and it will only be allowed to be deployed in the production environment. As a result, it will be shared between the two environments prod and non-prod.

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

**NOTE :** In a scenario in which the customer wishes to publish its Web Servers using the OELZ , an Public Load Balancer must be deployed within the public subnet in the HUB ( **L4 - Network Compartment** ), which will have as endpoints the Web Servers present in the subnet that will be part of the **L3 - Workload compartment.** Since connectivity is already configured via the Hub & Spoke architecture, all that needs to be done is to change the Security Lists associated with the subnets to enable traffic between the Load Balancer and the endpoints.


## **_Security Module_**

Oracle Cloud Infrastructure (OCI) is a Security-first Cloud Service that helps organizations reduce the risk of security threats for cloud workloads by putting our customers' Data Security and Privacy first.  This is achieved via the automation of security operations with simple, prescriptive, and integrated cloud-native security capabilities built into the OCI platform.  Oracle helps customers easily adopt OIC services and secure their cloud infrastructure, data, and applications.

The OELZ further supports Oracle's Security-First Cloud strategy tenets:

- Security should be simple—easy to use, deploy, and operate
- Security tools should offer guidance to help customers achieve strong security more easily
- Security should be integrated and automated, reducing manual security tasks and human errors
- Cloud security should be economically attractive, improving the cost of securing cloud workloads


# Mushop 3-tier Web Application

After the baseline "OELZ" stack has been installed , we will install Mushop Web Application on L3 workload compartment.

## **_Mushop Introduction_**

MuShop Complete is a polyglot micro-services application built to showcase a cloud native approach to application development on [Oracle Cloud Infrastructure][oci] using Oracle's [cloud native](https://www.oracle.com/cloud/cloud-native/) services.
- Mushop Topology 
![mushop_topo](<./images/mushop-topology.png> "mushop_topo")
- Mushop Services Architecture 
![mushop_diagram](<./images/mushop-service.png> "mushop_diagram")
MuShop is a showcase of several [Oracle Cloud Infrastructure][oci] services in a unified reference application. The sample application implements an e-commerce platform built as a set of micro-services. The accompanying content can be used to get started with cloud native application development on [Oracle Cloud Infrastructure][oci]. We will use Mushop 3-tier reference application is built to showcase the Oracle Cloud Infrastructure][oci] using OCI Free tier.


