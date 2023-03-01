## Configuration Guide (DO NOT UPDATE)

### Compartment
For the Workload stack, we have the below compartment architecture:
* Workload

To configure the compartment the required user inputs are:
* **enviroment_compartment_id**: the OCID of the higher level environment compartment
* **workload_compartment_name**: the name of workload compartment, by default OCI-ELZ-<Workload Name>-<Region>
* **workload_name**: the name of the workload
* **home_compartment_id**: the OCID of the compartment that the environment compartment build on.

