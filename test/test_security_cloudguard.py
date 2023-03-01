from pytest_terraform import terraform
import pytest
import oci


from test_helpers.oci import get_test_config

#unit tests for cloudguard portion of the security module
@pytest.mark.unit
@terraform("security_cloudguard", scope="session")
def test_cloudguard_target_created(security_cloudguard):
    conf = get_test_config()
    cloud_guard_client = oci.cloud_guard.CloudGuardClient(conf)

    env_comp_ocid = security_cloudguard.outputs["environment_compartment_id"]['value']
    cg_target = security_cloudguard['oci_cloud_guard_target.cloud_guard_target']

    target = cloud_guard_client.get_target(target_id=cg_target['id']).data

    assert target.lifecycle_state == 'ACTIVE'
    assert target.compartment_id == env_comp_ocid
    assert target.target_resource_type == 'COMPARTMENT'


@pytest.mark.unit
def test_cloudguard_target_responder_recipe(security_cloudguard):
    conf = get_test_config()
    cloud_guard_client = oci.cloud_guard.CloudGuardClient(conf)

    cg_target = security_cloudguard['oci_cloud_guard_target.cloud_guard_target']

    target = cloud_guard_client.get_target(target_id=cg_target['id']).data
    found = False
    for trr in target.target_responder_recipes:
        if trr.display_name == 'OCI Responder Recipe' and trr.owner == "ORACLE":
            found = True
    assert found

@pytest.mark.unit
def test_cloudguard_target_config_detector_recipe(security_cloudguard):
    conf = get_test_config()
    cloud_guard_client = oci.cloud_guard.CloudGuardClient(conf)

    cg_target = security_cloudguard['oci_cloud_guard_target.cloud_guard_target']

    target = cloud_guard_client.get_target(target_id=cg_target['id']).data
    found = False
    for tdr in target.target_detector_recipes:
        if tdr.display_name == 'OCI Configuration Detector Recipe' and tdr.owner == "ORACLE":
            found = True
    assert found

@pytest.mark.unit
def test_cloudguard_target_threat_detector_recipe(security_cloudguard):
    conf = get_test_config()
    cloud_guard_client = oci.cloud_guard.CloudGuardClient(conf)

    cg_target = security_cloudguard['oci_cloud_guard_target.cloud_guard_target']

    target = cloud_guard_client.get_target(target_id=cg_target['id']).data
    found = False
    for tdr in target.target_detector_recipes:
        if tdr.display_name == 'OCI Threat Detector Recipe' and tdr.owner == "ORACLE":
            found = True
    assert found

@pytest.mark.unit
def test_cloudguard_target_activity_detector_recipe(security_cloudguard):
    conf = get_test_config()
    cloud_guard_client = oci.cloud_guard.CloudGuardClient(conf)

    cg_target = security_cloudguard['oci_cloud_guard_target.cloud_guard_target']

    target = cloud_guard_client.get_target(target_id=cg_target['id']).data
    found = False
    for tdr in target.target_detector_recipes:
        if tdr.display_name == 'OCI Activity Detector Recipe' and tdr.owner == "ORACLE":
            found = True
    assert found
