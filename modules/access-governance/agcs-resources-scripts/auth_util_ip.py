import os
import oci
import requests
from requests.auth import HTTPBasicAuth


# def replace_space_with_new_line(str_input):
#     result = str_input
#     if str_input.count(' ') > 4:
#         start = "-----BEGIN PRIVATE KEY-----"
#         end = "-----END PRIVATE KEY-----"
#         extract_key = str_input[str_input.find(start) + len(start):str_input.rfind(end)]
#         extract_key = extract_key.replace(' ', "\\n")
#         result = start + extract_key + end
#     return result
#
#
# def init_agcs_user_pvt_keys():
#     parent_dir = os.path.realpath('.')
#     si_key_filename = os.path.join(parent_dir, 'resource', 'user_si_pvt_key.pem')
#     si_private_key = os.environ["ADMIN_PRIVATE_KEY_SERVICE_INSTANCE"]
#     si_pvt_key_file = open(si_key_filename, "w+")
#     if si_private_key and not si_private_key.isspace():
#         si_private_key = replace_space_with_new_line(si_private_key)
#         si_pvt_key_file.write(si_private_key.encode('raw_unicode_escape').decode('unicode_escape'))
#     else:
#         files = os.listdir(os.path.join(parent_dir, 'private_key_si'))
#         user_pvt_key_files = [file_ for file_ in files if file_.endswith('.pem')]
#         if user_pvt_key_files:
#             user_pvt_key_file = open(os.path.join(parent_dir, 'private_key_si', user_pvt_key_files[0]), "r")
#             file_contents = user_pvt_key_file.read()
#             user_pvt_key_file.close()
#             si_pvt_key_file.write(file_contents)
#     si_pvt_key_file.close()
#
#
# def init_admin_pvt_keys():
#     parent_dir = os.path.realpath('.')
#     connected_system_key_filename = os.path.join(parent_dir, 'resource', 'user_connected_system_pvt_key.pem')
#     connected_system_pvt_key_file = open(connected_system_key_filename, "w+")
#     connected_system_user_private_key = os.environ["AGCS_USER_PRIVATE_KEY_OCI_SYSTEM"]
#     if connected_system_user_private_key and not connected_system_user_private_key.isspace():
#         connected_system_user_private_key = replace_space_with_new_line(connected_system_user_private_key)
#         connected_system_pvt_key_file.write(connected_system_user_private_key.encode('raw_unicode_escape')
#                                             .decode('unicode_escape'))
#     connected_system_pvt_key_file.close()
#
# def get_admin_pvt_keys():
#     parent_dir = os.path.realpath('.')
#     admin_pvt_key_file = open(os.path.join(parent_dir, 'private-keys', 'admin_pvt_key.pem'), "r")
#     content_cs = admin_pvt_key_file.read()
#     admin_pvt_key_file.close()
#     return content_cs


def get_si_signer_and_config():
    config = get_admin_config()
    if not config:
        config = {}
        signer = oci.auth.signers.InstancePrincipalsDelegationTokenSigner(delegation_token=os.environ["OCI_obo_token"])
    else:
        signer = oci.Signer.from_config(config)
    return signer, config


def get_admin_config():
    admin_pvt_key_path = os.environ["ADMIN_PRIVATE_KEY_PATH"]
    config = None
    if admin_pvt_key_path and not admin_pvt_key_path.isspace():
        config = {"log_requests": False, "additional_user_agent": "", "pass_phrase": None,
                  'user': os.environ["ADMIN_OCID_SERVICE_INSTANCE"],
                  'tenancy': os.environ["ADMIN_TENANCY_OCID_SERVICE_INSTANCE"],
                  'key_file': admin_pvt_key_path,
                  'region': os.environ["ADMIN_REGION_SERVICE_INSTANCE"],
                  "fingerprint": os.environ["ADMIN_FINGERPRINT_SERVICE_INSTANCE"],
                  "service_endpoint": "https://access-governance." + os.environ["ADMIN_REGION_SERVICE_INSTANCE"]
                                      + ".oci.oraclecloud.com"
                  }
    elif config is None:
        private_key_file = os.environ.get("TF_VAR_api_private_key_path")
        private_key = os.environ.get("TF_VAR_api_private_key")
        tenancy = os.environ.get("TF_VAR_tenancy_ocid")
        user = os.environ.get("TF_VAR_current_user_ocid")
        fingerprint = os.environ.get("TF_VAR_api_fingerprint")
        region = os.environ.get("TF_VAR_region")
        config = {
            "log_requests": False,
            "additional_user_agent": "",
            "pass_phrase": None,
            "user": user,
            "fingerprint": fingerprint,
            "tenancy": tenancy,
            "region": region,
            "service_endpoint": "https://access-governance." + region + ".oci.oraclecloud.com"
        }
        if private_key_file is not None and not private_key_file.isspace():
            config["key_file"] = private_key_file
        elif private_key is not None and not private_key.isspace():
            config["key_content"] = private_key

    return config


def get_auth_url():
    return os.environ["IDCS_ENDPOINT"] + "/oauth2/v1/token"


def get_idcs_access_token(signer):
    token_url = get_auth_url()
    headers = {'Content-type': 'application/x-www-form-urlencoded'}
    body = {
        "grant_type": "urn:ietf:params:oauth:grant-type:token-exchange",
        "scope": "urn:opc:idm:__myscopes__",
        "requested_token_type": "urn:ietf:params:oauth:token-type:access_token"
    }
    response = requests.post(token_url, auth=signer, headers=headers, data=body)
    response_json = response.json()
    return response_json['access_token']


def get_ag_authorization_token(user, password, ag_instance_url):
    token_url = get_auth_url()
    headers = {'Content-type': 'application/x-www-form-urlencoded'}
    body = {
        "grant_type": "client_credentials",
        "scope": ag_instance_url
    }
    response = requests.post(token_url, auth=HTTPBasicAuth(user, password), headers=headers, data=body)
    response_json = response.json()

    return response_json['access_token']


def get_agcs_user_pvt_keys():
    use_existing_user = os.environ["USE_EXISTING_AGCS_USER"]
    private_key = os.environ["AGCS_USER_PRIVATE_KEY"]
    agcs_user_pvt_key_path = os.environ["AGCS_USER_PRIVATE_KEY_PATH"]
    if use_existing_user.lower() == "true":
        if agcs_user_pvt_key_path and not agcs_user_pvt_key_path.isspace():
            agcs_user_pvt_key_file = open(agcs_user_pvt_key_path, "r")
            content_cs = agcs_user_pvt_key_file.read()
            agcs_user_pvt_key_file.close()
        else:
            content_cs = private_key
    else:
        content_cs = private_key

    return content_cs


def should_verify_ssl():
    return not is_namespace_used()


def is_namespace_used():
    namespace_url = os.environ["NAMESPACE_SERVICE_ENDPOINT"]
    if namespace_url and not namespace_url.isspace():
        return True
    return False


