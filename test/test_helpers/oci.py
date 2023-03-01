import oci 
import os


def get_test_config():
    conf = {
        "user" : os.environ["TF_VAR_current_user_ocid"],
        "tenancy" : os.environ["TF_VAR_tenancy_ocid"],
        "fingerprint" : os.environ["TF_VAR_api_fingerprint"],
        "key_file" : os.environ["TF_VAR_api_private_key_path"],
        "region"  : os.environ["TF_VAR_region"],
    }
    oci.config.validate_config(conf)
    return conf

