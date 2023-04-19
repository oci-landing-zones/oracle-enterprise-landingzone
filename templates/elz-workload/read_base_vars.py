import json 
import argparse

def read_base_lz_vars(env, json_file):
    with open(json_file, 'r') as f:
        terr_out = json.load(f)
    
    if env == "P":
        key =  "prod_environment"
    else:
        key = "nonprod_environment"

    env_vars = terr_out[key]['value']
    drg_id = env_vars['drg_id']
    hub_vcn_id = env_vars['hub_vcn']
    hub_public_subnet_cidr = env_vars["hub_public_subnet_cidr"]
    hub_private_subnet_cidr = env_vars["hub_private_subnet_cidr"]

    compartments = env_vars["compartments"]
    net_comp_id = compartments["network"]["id"]
    env_comp_id = compartments["environment"]["id"]
    sec_comp_id = compartments["security"]["id"]
    sec_comp_name = compartments["security"]["name"]

    idomain = env_vars["identity_domain"]
    id_id = idomain["id"]
    id_name = idomain["display_name"]

    print(f"hub_vcn_id = \"{hub_vcn_id}\"")
    print(f"drg_id = \"{drg_id}\"")
    print(f"hub_public_subnet_cidr_block = \"{hub_public_subnet_cidr}\"")
    print(f"hub_private_subnet_cidr_block = \"{hub_private_subnet_cidr}\"")

    print(f"security_compartment_id = \"{sec_comp_id}\"")
    print(f"security_compartment_name = \"{sec_comp_name}\"")
    print(f"environment_compartment_id = \"{env_comp_id}\"")

    print(f"identity_domain_id = \"{id_id}\"")
    print(f"identity_domain_name = \"{id_name}\"")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Script to read outputs from base Landing Zone for Workload")
    parser.add_argument('-e','--environment',
                        choices=['N', 'P'],
                        default="P",
                        help="The environment (N or P) the workload will be deployed to")

    parser.add_argument('-f', '--json-output-file',
                        required=True,
                        help="File containing output of `terraform output -json` in base landing zone")

    args = parser.parse_args()
    read_base_lz_vars(args.environment, args.json_output_file)
  