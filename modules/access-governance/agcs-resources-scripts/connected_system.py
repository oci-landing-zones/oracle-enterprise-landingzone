import json
import oci
import requests
import auth_util_ip
import os


def get_instance_app_ocid(ag_si_name):
    signer, config = auth_util_ip.get_si_signer_and_config()
    identity_domains_client_obj = oci.identity_domains.IdentityDomainsClient(config,
                                                                             service_endpoint=os.environ[
                                                                                 "IDCS_ENDPOINT"], signer=signer)
    response = identity_domains_client_obj.list_apps(filter='displayName eq "AG-' + ag_si_name + '"')
    if response.status == 200 and response.data and response.data.resources:
        app_search_response = response.data.resources[0]
        return app_search_response.ocid
    else:
        return "NO APPS RETURNED!!!"


def get_app_details(ag_si_name):
    domain_app_id = get_instance_app_ocid(ag_si_name)
    signer, config = auth_util_ip.get_si_signer_and_config()
    identity_domains_client_obj = oci.identity_domains.IdentityDomainsClient(config=config,
                                                                             service_endpoint=os.environ[
                                                                                 "IDCS_ENDPOINT"], signer=signer)
    response = identity_domains_client_obj.get_app(domain_app_id,
                                                   attributes='clientSecret,grantedAppRoles,scopes,audience')
    # print(response.__dict__)
    client_cred = None
    if response.status == 200 and response.data and response.data.granted_app_roles and response.data.scopes:
        scope_url = response.data.scopes[0].fqs
        for app_role in response.data.granted_app_roles:
            if app_role.admin_role and str(app_role.display) == "AG_Administrator":
                client_cred = {"client_id": app_role.app_name, "client_secret": response.data.client_secret,
                               "scope_url": scope_url, "ag_service_instance_url": response.data.audience}
    return client_cred


def execute_tms_api(url, token, body, method):
    headers = {'Content-type': 'application/json',
               "Authorization": "Bearer " + token}

    if method == "GET":
        response = requests.get(url, headers=headers, data=None, verify=auth_util_ip.should_verify_ssl())
    else:
        response = requests.post(url, headers=headers, data=json.dumps(body), verify=auth_util_ip.should_verify_ssl())

    if response.status_code == 200 and response.text:
        return json.loads(response.text)


def add_cloud_gateway_connector(ag_access_token, ag_si_url):
    tms_base_url = ag_si_url + "target-management/20220518"
    template_path = "/templates?category=CLOUD_SERVICE_PROVIDER&displayName=OCI_TMPL&lifecycleState=ACTIVE&limit=1"
    add_target_path = "/targets"
    templates_response = execute_tms_api(tms_base_url + template_path, ag_access_token, None, "GET")
    if templates_response["items"]:
        private_key_from_file = auth_util_ip.get_agcs_user_pvt_keys()
        template_id = templates_response["items"][0]["id"]
        body = {
            "displayName": os.environ["OCI_SYSTEM_NAME"],
            "description": os.environ["OCI_SYSTEM_DESCRIPTION"],
            "scheduleCronExpression": "every 24 hour",
            "targetTemplateId": template_id,
            "targetParameters": {
                "items": [
                    {
                        "name": "apiKeyUserId",
                        "values": [
                            os.environ["AGCS_USER_OCID_OCI_SYSTEM"]
                        ]
                    },
                    {
                        "name": "apiKeyFingerprint",
                        "values": [
                            os.environ["AGCS_USER_FINGERPRINT_OCI_SYSTEM"]
                        ]
                    },
                    {
                        "name": "apiKeyPrivateKeyPEMValue",
                        "values": [
                            private_key_from_file
                        ]
                    },
                    {
                        "name": "apiKeyTenantId",
                        "values": [
                            os.environ["AGCS_USER_TENANCY_OCID_OCI_SYSTEM"]
                        ]
                    },
                    {
                        "name": "userRegion",
                        "values": [
                            os.environ["AGCS_USER_REGION_OCI_SYSTEM"]
                        ]
                    }
                ]
            }
        }
        response = execute_tms_api(tms_base_url + add_target_path, ag_access_token, body, "POST")
        if response and response["lifecycleState"] == "ACTIVE":
            return response


def execute_add_connected_system(ag_si_name):
    client_credentials = get_app_details(ag_si_name)
    access_token = auth_util_ip.get_ag_authorization_token(client_credentials.get("client_id"),
                                                           client_credentials.get("client_secret"),
                                                           client_credentials.get("scope_url"))
    return add_cloud_gateway_connector(access_token, client_credentials.get("ag_service_instance_url"))
