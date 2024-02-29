import oci
import os
import json
import base64
import auth_util_ip


def delete_instance(ag_cp_composite_client):
    governance_instance_id = os.environ["instanceOCID"]
    response = ag_cp_composite_client.delete_governance_instance_and_wait_for_state(governance_instance_id,
                                                                                    wait_for_states=["DELETED",
                                                                                                     "NEEDS_ATTENTION"])
    json_res = json.dumps(str(response.__dict__), indent=2)
    output = base64.b64encode(json_res.encode()).decode()
    print(output)


if __name__ == '__main__':
    signer_object, config_object = auth_util_ip.get_si_signer_and_config()
    service_endpoint = ("https://access-governance." + os.environ["ADMIN_REGION_SERVICE_INSTANCE"]
                        + ".oci.oraclecloud.com")
    if auth_util_ip.is_namespace_used():
        service_endpoint = os.environ["NAMESPACE_SERVICE_ENDPOINT"]
    access_governance_cp_client = oci.access_governance_cp.AccessGovernanceCPClient(config=config_object,
                                                                                    service_endpoint=service_endpoint,
                                                                                    signer=signer_object)

    agCompositeClient = oci.access_governance_cp.AccessGovernanceCPClientCompositeOperations(
        access_governance_cp_client, config=config_object, service_endpoint=service_endpoint)

    delete_instance(agCompositeClient)
