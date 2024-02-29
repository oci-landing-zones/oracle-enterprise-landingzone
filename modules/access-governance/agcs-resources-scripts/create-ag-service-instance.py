import os
import oci
from oci import exceptions
from requests.exceptions import SSLError

import auth_util_ip
import connected_system
import json
import base64

ag_license_dict = {"Access Governance Premium": "AG_PREMIUM",
                   "Access Governance for Oracle Workloads": "AG_ORACLE_WORKLOADS",
                   "Access Governance for Oracle Cloud Infrastructure": "AG_OCI"}


def create_instance(ag_cp_composite_client, signer):
    token = auth_util_ip.get_idcs_access_token(signer)
    details = oci.access_governance_cp.models.CreateGovernanceInstanceDetails(
        display_name=os.environ["SERVICE_INSTANCE_DISPLAY_NAME"],
        description=os.environ["SERVICE_INSTANCE_DESCRIPTION"],
        license_type=ag_license_dict[os.environ["AG_LICENSE_TYPE"]],
        tenancy_namespace=get_name_space(),
        compartment_id=os.environ["SERVICE_INSTANCE_COMPARTMENT_OCID"],
        idcs_access_token=token)
    si_name = None
    si_id = None
    output = None
    try:
        response = (ag_cp_composite_client
                    .create_governance_instance_and_wait_for_state(details, wait_for_states=["ACTIVE",
                                                                                             "NEEDS_ATTENTION"]))
        json_res = json.dumps(str(response.__dict__['data']), indent=2)
        output = json_res.encode()
        si_name = response.__dict__['data'].display_name
        si_id = "-" + response.__dict__['data'].id[len(response.__dict__['data'].id) - 10:]
    # except exceptions.ServiceError as errorResponse:
    #     si_name = os.environ["SERVICE_INSTANCE_DISPLAY_NAME"]
    #     if errorResponse.code == "NotAuthorizedOrResourceAlreadyExists":
    #         si_list = (ag_cp_composite_client.client
    #                    .list_governance_instances(os.environ["SERVICE_INSTANCE_COMPARTMENT_OCID"]))
    #         for instance_summary in si_list.data.items:
    #             if instance_summary.display_name and str(instance_summary.display_name) == si_name:
    #                 output = {"id": instance_summary.id}
    except SSLError:
        pass

    should_create_connected_system = os.environ["SHOULD_CREATE_CONNECTED_SYSTEM"]
    if should_create_connected_system == "true" and (si_name and not si_name.isspace()):
        connected_system.execute_add_connected_system(si_name+si_id)
    if output and not output.isspace():
        print(base64.b64encode(output).decode())


def get_name_space():
    signer_obj, config_obj = auth_util_ip.get_si_signer_and_config()
    object_storage_client = oci.object_storage.ObjectStorageClient(config=config_obj, signer=signer_obj)
    namespace_response = object_storage_client.get_namespace()
    return namespace_response.__dict__['data']


if __name__ == '__main__':
    service_endpoint = ("https://access-governance." + os.environ["ADMIN_REGION_SERVICE_INSTANCE"]
                        + ".oci.oraclecloud.com")

    if auth_util_ip.is_namespace_used():
        service_endpoint = os.environ["NAMESPACE_SERVICE_ENDPOINT"]

    signer_object, config_object = auth_util_ip.get_si_signer_and_config()
    access_governance_cp_client = oci.access_governance_cp.AccessGovernanceCPClient(config=config_object,
                                                                                    signer=signer_object,
                                                                                    service_endpoint=service_endpoint)
    agCompositeClient = oci.access_governance_cp.AccessGovernanceCPClientCompositeOperations(
        access_governance_cp_client, config=config_object, signer=signer_object, service_endpoint=service_endpoint)
    create_instance(agCompositeClient, signer_object)
