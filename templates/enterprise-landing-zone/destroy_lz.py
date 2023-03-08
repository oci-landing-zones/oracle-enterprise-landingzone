import argparse
import os
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime
from typing import List, Dict
import subprocess

import oci
from tqdm import tqdm


class DestroyLandingZone:
    def __init__(self, parent_cmp: str, region_key: str, env_prefixes: List[str],  oci_config: str, profile_name: str):
        '''
        Inputs include parent compartment as its name can be overridden via tfvar.
        Region key and Environment prefix are variables used in compartment naming as well.
        '''

        self._conf_file = oci_config
        self.config = oci.config.from_file(
            file_location=self.config_filename,
            profile_name=profile_name
        )

        self.identity_client = oci.identity.IdentityClient(self.config)
        self.os_client = oci.object_storage.ObjectStorageClient(self.config)
        self.log_analytics_client = oci.log_analytics.LogAnalyticsClient(
            self.config)
        self.identity_client = oci.identity.IdentityClient(self.config)
        self.key_management_client = oci.key_management.KmsVaultClient(
            self.config)
        print("finished initializing oci clients")

        self.tenancy_id = self.config["tenancy"]
        self.parent_cmp = parent_cmp
        self.os_namespace = self.get_os_namespace()
        self.region_key = region_key
        self.env_prefixes = env_prefixes

    @property
    def config_filename(self):
        fn = os.path.join(os.environ["HOME"], self._conf_file)
        return fn

    def get_cmps(self, env_prefix: str) -> Dict[str, str]:
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

    def get_os_namespace(self):
        os_namespace = self.os_client.get_namespace()
        return os_namespace.data

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
                time_data_ended=datetime.now().strftime(
                    "%Y-%m-%dT%H:%M:%S.%fZ"),
                compartment_id_in_subtree=True),
            # wait_for_states=["SUCCEEDED"]
        )
        # purge_storage_data_response = oci.log_analytics.LogAnalyticsClientCompositeOperations(self.log_analytics_client).purge_storage_data_and_wait_for_state(
        #     namespace_name=self.os_namespace,
        #     purge_storage_data_details=oci.log_analytics.models.PurgeStorageDataDetails(
        #         compartment_id=cmp_id,
        #         time_data_ended=datetime.now().strftime(
        #             "%Y-%m-%dT%H:%M:%S.%fZ"),
        #         compartment_id_in_subtree=True),
        #     wait_for_states=["SUCCEEDED"]
        # )

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

    def move_vaults(self, cmp_id):
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

    def update_terraform_state(self):
        process = subprocess.run(["terraform state rm module.nonprod_environment.module.security.module.vault.oci_kms_vault.vault"],
                                 stdout=subprocess.PIPE,
                                 universal_newlines=True,
                                 shell=True)
        process = subprocess.run(["terraform state rm module.prod_environment.module.security.module.vault.oci_kms_vault.vault"],
                                 stdout=subprocess.PIPE,
                                 universal_newlines=True,
                                 shell=True)

    def deactivate_domains(self, cmp_id):
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
        compartments = self.get_cmps(env_prefix)
        bucket_cmps = [compartments["parent"], compartments["log"]]

        print("beginning bucket destroy")
        bucket_names = []
        for cmp in bucket_cmps:
            bucket_names += self.get_bucket_names(cmp)

        print(bucket_names)
        with ThreadPoolExecutor(max_workers=4) as p:
            p.map(self.delete_bucket_all, bucket_names)

        print("beginning log analytics destroy")
        self.purge_log_analytics(compartments["security"])
        self.delete_log_analytics_group(compartments["security"])

        print("beginning vault move")
        self.move_vaults(compartments["security"])
        # self.update_terraform_state()

        print("deactivating domains")
        self.deactivate_domains(compartments["security"])

        print("finished destroying ___\n\n")

    def run_all(self):
        for env in self.env_prefixes:
            self.delete_environment(env)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Destroy Landing Zone Lingering Resources",
        epilog="python destroy_lz.py -r IAD -e P N")

    parser.add_argument("-c", "--cmp",
                        default="OCI-ELZ-CMP-HOME",
                        help="Name of the parent cmp")

    parser.add_argument("-r", "--region_key",
                        help="Region Key used in compartment naming eg. IAD, PHX")

    parser.add_argument("-e", "--env_prefixes", nargs="+",
                        default=["P", "N"],
                        help="Environment prefix used in compartment naming")

    parser.add_argument("--profile",
                        default="DEFAULT",
                        help="OCI profile you want to use in the specified region")

    parser.add_argument("--oci_config",
                        default=".oci/config",
                        help="Path to the OCI Configuration file")

    args = parser.parse_args()
    generate_schema = DestroyLandingZone(
        parent_cmp=args.cmp,
        region_key=args.region_key,
        env_prefixes=args.env_prefixes,
        oci_config=args.oci_config,
        profile_name=args.profile
    )
    generate_schema.run_all()
