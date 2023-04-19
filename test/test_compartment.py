from pytest_terraform import terraform
import pytest
import oci

from test_helpers.oci import get_test_config


# Deploy compartments module with all input variables changed to a custom value
# Validate the compartment structure
@pytest.mark.skip(reason="Compartment delete too slow")
@pytest.mark.unit
@terraform("compartment", scope="session")
def test_l1_compartment_create(compartment):
    config = get_test_config()
    identity_client = oci.identity.IdentityClient(config)

    out_parent_cmp_id = compartment.outputs["home_compartment_id"]["value"]
    out_env_cmp_id = compartment.outputs["compartment"]["value"]["environment"]["id"]
    env_prefix = "T"
    region_key = "IAD"

    env_cmp_name = f"OCI-ELZ-{env_prefix}-CMP"
    env_cmps_response = identity_client.list_compartments(
        compartment_id=out_parent_cmp_id,
        name=env_cmp_name
    )

    # assert api found cmp tree match
    assert len(env_cmps_response.data) > 0
    env_cmp_id = env_cmps_response.data[0].id

    # assert output matches actual api output
    assert out_env_cmp_id == env_cmp_id

@pytest.mark.skip(reason="Compartment delete too slow")
@pytest.mark.unit
@terraform("compartment", scope="session")
def test_l2_compartment_create(compartment):
    config = get_test_config()
    identity_client = oci.identity.IdentityClient(config)

    env_prefix = "T"
    region_key = "IAD"
    out_env_cmp_id = compartment.outputs["compartment"]["value"]["environment"]["id"]
    out_shared_cmp_id = compartment.outputs["compartment"]["value"]["shared"]["id"]
    out_log_cmp_id = compartment.outputs["compartment"]["value"]["logging"]["id"]

    log_cmp_name = f"OCI-ELZ-{env_prefix}-LOG-{region_key}"
    log_cmps_response = identity_client.list_compartments(
        compartment_id=out_env_cmp_id,
        name=log_cmp_name
    )
    assert len(log_cmps_response.data) > 0
    log_cmp_id = log_cmps_response.data[0].id
    assert out_log_cmp_id == log_cmp_id

    shared_cmp_name = f"OCI-ELZ-{env_prefix}-SRD-CMP-{region_key}"
    shared_cmps_response = identity_client.list_compartments(
        compartment_id=out_env_cmp_id,
        name=shared_cmp_name
    )
    assert len(shared_cmps_response.data) > 0
    shared_cmp_id = shared_cmps_response.data[0].id
    assert out_shared_cmp_id == shared_cmp_id

    # # workload is created in environment template not compartment template
    # workload_cmp_name = f"OCI-ELZ-{env_prefix}-Workload1-{region_key}"
    # workload_cmps_response = identity_client.list_compartments(
    #     compartment_id=out_env_cmp_id,
    #     name=workload_cmp_name
    # )
    # assert len(workload_cmps_response.data) > 0
    # workload_cmp_id = workload_cmps_response.data[0].id

@pytest.mark.skip(reason="Compartment delete too slow")
@pytest.mark.unit
@terraform("compartment", scope="session")
def test_l3_compartment_create(compartment):
    config = get_test_config()
    identity_client = oci.identity.IdentityClient(config)

    env_prefix = "T"
    region_key = "IAD"
    out_shared_cmp_id = compartment.outputs["compartment"]["value"]["shared"]["id"]
    out_net_cmp_id = compartment.outputs["compartment"]["value"]["network"]["id"]
    out_security_cmp_id = compartment.outputs["compartment"]["value"]["security"]["id"]

    security_cmp_name = f"OCI-ELZ-{env_prefix}-SRD-SEC"
    security_cmps_response = identity_client.list_compartments(
        compartment_id=out_shared_cmp_id,
        name=security_cmp_name
    )
    assert len(security_cmps_response.data) > 0
    security_cmp_id = security_cmps_response.data[0].id
    assert security_cmp_id == out_security_cmp_id

    net_cmp_name = f"OCI-ELZ-{env_prefix}-SRD-NET"
    net_cmps_response = identity_client.list_compartments(
        compartment_id=out_shared_cmp_id,
        name=net_cmp_name
    )
    assert len(net_cmps_response.data) > 0
    net_cmp_id = net_cmps_response.data[0].id
    assert net_cmp_id == out_net_cmp_id
