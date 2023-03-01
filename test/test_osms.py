#!/usr/bin/env python

import oci
import sys
import pytest
from pytest_terraform import terraform

from test_helpers.oci import get_test_config


def listAllManaged(compartmentId):
    list_module_stream_profiles_on_managed_instance_response = osms_client.list_module_stream_profiles_on_managed_instance(
        compartment_id=compartmentId
    )
    return list_module_stream_profiles_on_managed_instance_response.data
def listAllManagedCompartment(compartmentId):
    list_managed_instance_groups_response = osms_client.list_managed_instance_groups(
        compartment_id=compartmentId
    )
    return list_managed_instance_groups_response.data

def list_dynamic_group(compartmentId):
    list_dynamic_groups_response = identity_client.list_dynamic_groups(
        compartment_id=compartmentId
    )
    return list_dynamic_groups_response.data

def find_dynamic_group_ocid (dg_data, dg_name):

    dg_name_data = [ dg for dg in dg_data if dg.name==dg_name][0]
    if dg_name_data:
        return dg_name_data.id
    else:
        print ("Not Found the Dynamic Group OCID")
        sys.exit()

def get_dynamic_info(dynamicId, identity_client):
    get_dynamic_group_response = identity_client.get_dynamic_group(
        
        dynamic_group_id=dynamicId
    )
    return get_dynamic_group_response.data

def check_dg_lifecycle_state(dg_data, state):
    if dg_data.lifecycle_state == state:
        return True
    else:
        return False

# TODO: Remove this `skip` to enable test once everything is working. 
@pytest.mark.skip(reason="Waiting for Terraform test harness code to make this work.")
@pytest.mark.unit
@terraform("osms_detail", scope="session")
def test_osms_unit_test_case(osms_detail):
    config = get_test_config()
    osms_client     = oci.os_management.OsManagementClient(config)
    identity_client = oci.identity.IdentityClient(config)
    dynamic_group_id        = osms_detail.outputs["dynamic_group_detail"]['id']
    dynamic_group_name      = osms_detail.outputs["dynamic_group_detail"]['name']
    dg_data                 = get_dynamic_info(dynamic_group_id, identity_client)
    expected_state          =  "ACTIVE"
    actual_state            = dg_data.lifecycle_state
    assert expected_state == actual_state


