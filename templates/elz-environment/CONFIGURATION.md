## Configuration Guide (DO NOT UPDATE)

### Compartment
For the Environment stack, we have the below compartment architecture:
* Environment Compartment
    * Shared Infrastructure
        * Network
        * Security
    * Logging
    * Backup

To configure the compartment the required user inputs are:
* **environment_compartment_name**: the name of the top level environment compartment
* **environment_prefix**: the 1 character string representing the environment eg. P (prod), N (non-prod), D, T, U
* **home_compartment_id**: the OCID of the compartment that the environment compartment build on.

Note that:
* The default value of **enable_logging** and **enable_tf_state_backup** which control the creation of
the Logging Compartment and the Backup Compartment are set to false. Those two variables need to be true
to create the Logging Compartment and the Backup Compartment.
