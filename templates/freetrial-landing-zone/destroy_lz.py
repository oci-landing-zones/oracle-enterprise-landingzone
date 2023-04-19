import argparse
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime
from typing import Dict, List

import oci
from tqdm import tqdm


class DestroyLandingZone:
    def __init__(self, parent_cmp: str, region_key: str, resource_label: str, oci_config: str = "~/.oci/config", profile_name: str = "DEFAULT"):

        self.config = oci.config.from_file(
            file_location=oci_config,
            profile_name=profile_name
        )

        self.identity_client = oci.identity.IdentityClient(self.config)
        self.os_client = oci.object_storage.ObjectStorageClient(self.config)
        self.log_analytics_client = oci.log_analytics.LogAnalyticsClient(
            self.config)
        self.identity_client = oci.identity.IdentityClient(self.config)
        self.key_management_client = oci.key_management.KmsVaultClient(
            self.config)
        self.sch_client = oci.sch.ServiceConnectorClient(self.config)

        self.tenancy_id = self.config["tenancy"]
        self.os_namespace = self.get_os_namespace()

        self.parent_cmp = parent_cmp
        self.region_key = region_key
        self.resource_label = resource_label

    def get_os_namespace(self) -> str:
        os_namespace = self.os_client.get_namespace()
        return os_namespace.data

    def get_elz_cmps(self, env_prefix: str) -> Dict[str, str]:
        parent_cmps_response = self.identity_client.list_compartments(
            compartment_id=self.tenancy_id,
            name=self.parent_cmp
        )
        parent_cmp_id = parent_cmps_response.data[0].id

        env_cmp_name = f"OCI-ELZ-{env_prefix}-CMP"
        env_cmps_response = self.identity_client.list_compartments(
            compartment_id=parent_cmp_id,
            name=env_cmp_name
        )
        env_cmp_id = env_cmps_response.data[0].id

        log_cmp_name = f"OCI-ELZ-{env_prefix}-LOG-{self.region_key}"
        log_cmps_response = self.identity_client.list_compartments(
            compartment_id=env_cmp_id,
            name=log_cmp_name
        )
        log_cmp_id = log_cmps_response.data[0].id

        shared_cmp_name = f"OCI-ELZ-{env_prefix}-SRD-CMP-{self.region_key}"
        shared_cmps_response = self.identity_client.list_compartments(
            compartment_id=env_cmp_id,
            name=shared_cmp_name
        )
        shared_cmp_id = shared_cmps_response.data[0].id

        security_cmp_name = f"OCI-ELZ-{env_prefix}-SRD-SEC"
        security_cmps_response = self.identity_client.list_compartments(
            compartment_id=shared_cmp_id,
            name=security_cmp_name
        )
        security_cmp_id = security_cmps_response.data[0].id

        cmp_map = {
            "parent": parent_cmp_id,
            "env": env_cmp_id,
            "log": log_cmp_id,
            "shared": shared_cmp_id,
            "security": security_cmp_id
        }

        return cmp_map

    def get_scca_cmps(self) -> Dict[str, str]:
        parent_cmps_response = self.identity_client.list_compartments(
            compartment_id=self.tenancy_id,
            name=self.parent_cmp
        )
        parent_cmp_id = parent_cmps_response.data[0].id

        vdms_cmp_name = f"OCI-SCCA-LZ-VDMS-{self.region_key}-{self.resource_label}"
        vdms_cmps_response = self.identity_client.list_compartments(
            compartment_id=parent_cmp_id,
            name=vdms_cmp_name
        )
        vdms_cmp_id = vdms_cmps_response.data[0].id

        vdss_cmp_name = f"OCI-SCCA-LZ-VDSS-{self.region_key}-{self.resource_label}"
        vdss_cmps_response = self.identity_client.list_compartments(
            compartment_id=parent_cmp_id,
            name=vdss_cmp_name
        )
        vdss_cmp_id = vdss_cmps_response.data[0].id

        log_cmp_name = f"OCI-SCCA-LZ-Logging-{self.region_key}-{self.resource_label}"
        log_cmps_response = self.identity_client.list_compartments(
            compartment_id=parent_cmp_id,
            name=log_cmp_name
        )
        log_cmp_id = log_cmps_response.data[0].id

        iac_cmp_name = f"OCI-SCCA-LZ-IAC-TF-Configbackup-{self.resource_label}"
        iac_cmps_response = self.identity_client.list_compartments(
            compartment_id=parent_cmp_id,
            name=iac_cmp_name
        )
        iac_cmp_id = iac_cmps_response.data[0].id

        cmp_map = {
            "parent": parent_cmp_id,
            "vdms": vdms_cmp_id,
            "vdss": vdss_cmp_id,
            "log": log_cmp_id,
            "iac": iac_cmp_id
        }

        return cmp_map

    def get_sch_ids(self, cmp_id: str) -> List[str]:
        list_service_connectors_response = self.sch_client.list_service_connectors(
            compartment_id=cmp_id
        )
        sch_ids = [d.id for d in list_service_connectors_response.data.items]
        return sch_ids

    def delete_sch(self, sch_id: str):
        delete_service_connector_response = self.sch_client.delete_service_connector(
            service_connector_id=sch_id
        )

    def get_bucket_names(self, cmp_id: str) -> List[str]:
        buckets_response = self.os_client.list_buckets(
            compartment_id=cmp_id,
            namespace_name=self.os_namespace
        )

        bucket_names = [d.name for d in buckets_response.data]
        return bucket_names

    def delete_retention_rules(self, bucket_name: str):
        retention_rule_response = self.os_client.list_retention_rules(
            namespace_name=self.os_namespace,
            bucket_name=bucket_name
        )
        retention_rules = retention_rule_response.data.items

        for rule in retention_rules:
            retention_rule_response = self.os_client.delete_retention_rule(
                namespace_name=self.os_namespace,
                bucket_name=bucket_name,
                retention_rule_id=rule.id
            )

    def delete_bucket_contents(self, bucket_name: str):
        bucket_files = []
        next_start_with = ""
        while next_start_with != None:
            list_files = self.os_client.list_objects(
                self.os_namespace,
                bucket_name,
                start=next_start_with
            )

            next_start_with = list_files.data.next_start_with
            if not list_files.data.objects:
                break
            bucket_files += list_files.data.objects

        for filenames in tqdm(bucket_files, desc=f'bucket {bucket_name}'):
            self.os_client.delete_object(
                self.os_namespace,
                bucket_name,
                filenames.name
            )

    def delete_bucket(self, bucket_name: str):
        delete_bucket_response = self.os_client.delete_bucket(
            namespace_name=self.os_namespace,
            bucket_name=bucket_name
        )

    def delete_bucket_all(self, bucket_name: str):
        self.delete_retention_rules(bucket_name)
        self.delete_bucket_contents(bucket_name)
        self.delete_bucket(bucket_name)

    def purge_log_analytics(self, cmp_id: str):
        purge_storage_data_response = self.log_analytics_client.purge_storage_data(
            namespace_name=self.os_namespace,
            purge_storage_data_details=oci.log_analytics.models.PurgeStorageDataDetails(
                compartment_id=cmp_id,
                time_data_ended=datetime.now().strftime("%Y-%m-%d") + "T23:59",
                purge_query_string="*",
                compartment_id_in_subtree=True
            ),
        )

        wait_for_resource_id = purge_storage_data_response.headers['opc-work-request-id']
        waiter_result = oci.wait_until(
            self.log_analytics_client,
            self.log_analytics_client.get_storage_work_request(
                wait_for_resource_id, self.os_namespace),
            "status",
            "SUCCEEDED"
        )

    def delete_log_analytics_group(self, cmp_id: str):
        list_log_analytics_log_groups_response = self.log_analytics_client.list_log_analytics_log_groups(
            namespace_name=self.os_namespace,
            compartment_id=cmp_id
        )
        log_groups = list_log_analytics_log_groups_response.data.items

        for group in log_groups:
            delete_log_analytics_log_group_response = self.log_analytics_client.delete_log_analytics_log_group(
                namespace_name=self.os_namespace,
                log_analytics_log_group_id=group.id
            )
            print(delete_log_analytics_log_group_response.data)

    def move_vaults(self, cmp_id: str):
        list_vaults_response = self.key_management_client.list_vaults(
            compartment_id=cmp_id
        )
        vaults = list_vaults_response.data

        for vault in vaults:
            if vault.lifecycle_state != "CREATED":
                print(
                    f"ignoring vault {vault.display_name} not in created state")
                continue

            change_vault_compartment_response = self.key_management_client.change_vault_compartment(
                vault_id=vault.id,
                change_vault_compartment_details=oci.key_management.models.ChangeVaultCompartmentDetails(
                    compartment_id=self.tenancy_id
                )
            )

    def deactivate_domains(self, cmp_id: str):
        list_domains_response = self.identity_client.list_domains(
            compartment_id=cmp_id
        )
        domains = list_domains_response.data

        for domain in domains:
            deactivate_domain_response = self.identity_client.deactivate_domain(
                domain_id=domain.id
            )

    def delete_environment(self, env_prefix: str):
        print(f"beginning env {env_prefix} destroy")

        print("fetching compartment ids")
        compartments = self.get_elz_cmps(env_prefix)

        print("deactivating domains")
        self.deactivate_domains(compartments["security"])

        # vault only needs to be moved out of the landing zone compartments
        # - once you run destroy, terraform will destroy it where it is
        # also note vault can only be moved in an ACTIVE state
        print("beginning vault move")
        self.move_vaults(compartments["security"])

        # delete sc hubs to stop logs flowing into buckets and log groups
        print("beginning service connector destroy")
        sch_ids = self.get_sch_ids(compartments["security"])
        for sch in sch_ids:
            self.delete_sch(sch)

        print("beginning bucket destroy")
        bucket_cmps = [compartments["parent"], compartments["log"]]
        bucket_names = []
        for cmp in bucket_cmps:
            bucket_names += self.get_bucket_names(cmp)

        with ThreadPoolExecutor(max_workers=3) as p:
            p.map(self.delete_bucket_all, bucket_names)

        print("beginning log analytics destroy")
        self.purge_log_analytics(compartments["security"])
        self.delete_log_analytics_group(compartments["security"])

        print("finished destroying ___\n\n")

    def destroy_scca(self):
        print("beginning elz destroy")

        print("fetching compartment ids")
        compartments = self.get_scca_cmps()

        print("deactivating domains")
        self.deactivate_domains(compartments["vdms"])

        print("beginning vault move")
        self.move_vaults(compartments["vdms"])

        print("beginning service connector destroy")
        sch_ids = self.get_sch_ids(compartments["vdms"])
        for sch in sch_ids:
            self.delete_sch(sch)

        print("beginning bucket destroy")
        bucket_cmps = [compartments["iac"], compartments["log"]]
        bucket_names = []
        for cmp in bucket_cmps:
            bucket_names += self.get_bucket_names(cmp)

        with ThreadPoolExecutor(max_workers=3) as p:
            p.map(self.delete_bucket_all, bucket_names)

        print("beginning log analytics destroy")
        self.purge_log_analytics(compartments["vdms"])
        self.delete_log_analytics_group(compartments["vdms"])


if __name__ == "__main__":
    '''
    The script cleans up lingering resources that block terraform destroy.  Once the
    script has been run, service connectors, buckets, and log analytics log groups 
    will be deleted, identity domains deactivated, and vaults moved to the root
    compartment. Terraform destroy will need to be run after.

    To run the script ensure you have python3 installed as well as an oci api key.
        Verify the profile name(eg. DEFAULT) by checking the config file found at ~/.oci/config.
    Install dependencies using the command: 
        pip install oci tqdm.
    Run the command (from the templates/enterprise-landing-zone directory)
    for ELZ:
        python destroy_lz.py -r IAD -e P N -c OCI-ELZ-CMP-HOME 
    for SCCA:
        python destroy_lz.py -r IAD -l ARJ2 -c OCI-SCCA-LZ-Home-IAD-ARJ2
    '''

    parser = argparse.ArgumentParser(
        description="Destroy Landing Zone Lingering Resources")

    parser.add_argument("-c", "--cmp",
                        default="OCI-ELZ-CMP-HOME",
                        help="Name of the parent cmp")

    parser.add_argument("-r", "--region_key",
                        help="Region Key used in compartment naming eg. IAD, PHX")

    parser.add_argument("-e", "--elz_envs", nargs="+",
                        default=["P", "N"],
                        help="Delete ELZ Landing Zone Environments by prefix eg. P, N")

    parser.add_argument("-l", "--scca_label",
                        help="Delete SCCA Landing Zone with specified resource label")

    parser.add_argument("--delete_buckets", nargs="+",
                        help="Delete buckets by bucket name")

    parser.add_argument("--profile",
                        default="DEFAULT",
                        help="OCI profile you want to use in the specified region")

    parser.add_argument("--oci_config",
                        default="~/.oci/config",
                        help="Path to the OCI Configuration file")

    args = parser.parse_args()
    destroy_lz = DestroyLandingZone(
        parent_cmp=args.cmp,
        region_key=args.region_key,
        resource_label=args.scca_label,
        oci_config=args.oci_config,
        profile_name=args.profile
    )

    if args.delete_buckets:
        for bucket in args.delete_buckets:
            destroy_lz.delete_bucket_all(bucket)
    elif args.scca_label:
        destroy_lz.destroy_scca()
    elif args.elz_envs:
        for env in args.elz_envs:
            destroy_lz.delete_environment(env)
    else:
        print("Select only one of the following flags: delete_buckets, scca_label, or elz_envs.")
