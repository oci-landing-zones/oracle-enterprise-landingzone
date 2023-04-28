import json 
import argparse


def get_workload_vars(json_file):
    with open(json_file, 'r') as f:
        wrk_output = json.load(f)
    
    cmp_name = wrk_output.get("compartment_name", {}).get("value")
    subnets = wrk_output.get("subnet_cidr_blocks", {}).get("value", [])

    return cmp_name, subnets

def get_from_env(base_output, env_name):
    env_output = base_output.get(env_name, {}).get("value", {})
    cmp_name = env_output.get("workload_compartment_name")
    return cmp_name

def hcltuple(items):
    # HCL is picky about quotes, and we'd rather not add the HCL lib dependency...
    return "[" + ", ".join([f"\"{i}\"" for i in items]) + "]"

def read_workload_vars(env, base_json_file, we_json_files=None):
    if not we_json_files:
        we_json_files = []
    compartment_names = []
    subnets = []
    env_name = f"{env}_environment"

    with open(base_json_file, 'r') as f:
        terr_out = json.load(f)    
        cname = get_from_env(terr_out, env_name)
        if cname:
            compartment_names.append(cname)

    for wfile in we_json_files:
        cname, subs = get_workload_vars(wfile)
        if cname:
            compartment_names.append(cname)
        for sn in subs:
            subnets.append(sn)

    print(f"{env}_additional_workload_subnets_cidr_blocks = {hcltuple(subnets)}")
    print(f"{env}_workload_compartment_names = {hcltuple(compartment_names)}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Script to read workload-related outputs from base and workload expansion(s)")

    parser.add_argument('-f', '--base-output-file',
                        required=True,
                        help="File containing output of `terraform output -json` in base landing zone")
 
    parser.add_argument('-p', '--prod-workload-output',
                        action='append',
                        help="File containing output of `terraform output -json` in workload expansion")

    parser.add_argument('-n', '--nonprod-workload-output',
                        action='append',
                        help="File containing output of `terraform output -json` in workload expansion")


    args = parser.parse_args()
    read_workload_vars("prod", args.base_output_file, args.prod_workload_output)
    read_workload_vars("nonprod", args.base_output_file, args.nonprod_workload_output)
