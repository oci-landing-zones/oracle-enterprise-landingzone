from pytest_terraform import terraform
import pytest
import oci


#from test_helpers.network.nettest import NetTest
from test_helpers.oci import get_test_config

#unit tests for bastion portion of the security module
@pytest.mark.unit
@terraform("security_bastion", scope="session")
def test_bastion_create(security_bastion):
    conf = get_test_config()
    bastion_client = oci.bastion.BastionClient(conf)

    tf_bast = security_bastion["oci_bastion_bastion.bastion"]
    bast_id = tf_bast['id']

    # Did terraform output right id?
    out_bast_id = security_bastion.outputs["bastion_id"]['value']
    assert bast_id == out_bast_id

    #can we get the bastion? 
    api_bast_resp = bastion_client.get_bastion(bastion_id=bast_id)
    api_bast = api_bast_resp.data
    
    assert api_bast.id == bast_id
    
@pytest.mark.unit
def test_bastion_active(security_bastion):
    conf = get_test_config()
    bastion_client = oci.bastion.BastionClient(conf)

    bast_id = security_bastion.outputs["bastion_id"]['value']

    api_bast_resp = bastion_client.get_bastion(bastion_id=bast_id)
    api_bast = api_bast_resp.data

    api_bast_resp = bastion_client.get_bastion(bastion_id=bast_id)
    api_bast = api_bast_resp.data

    # is it active ?
    assert api_bast.lifecycle_state == "ACTIVE"

@pytest.mark.unit
def test_bastion_compartment(security_bastion):
    conf = get_test_config()
    bastion_client = oci.bastion.BastionClient(conf)

    bast_id = security_bastion.outputs["bastion_id"]['value']

    api_bast_resp = bastion_client.get_bastion(bastion_id=bast_id)
    api_bast = api_bast_resp.data

    api_bast_resp = bastion_client.get_bastion(bastion_id=bast_id)
    api_bast = api_bast_resp.data

    # is it in the right compartment ?
    sec_comp = security_bastion.outputs["security_compartment_id"]['value']
    assert api_bast.compartment_id == sec_comp

@pytest.mark.unit
def test_bastion_subnet(security_bastion):
    conf = get_test_config()
    bastion_client = oci.bastion.BastionClient(conf)

    bast_id = security_bastion.outputs["bastion_id"]['value']

    api_bast_resp = bastion_client.get_bastion(bastion_id=bast_id)
    api_bast = api_bast_resp.data

    api_bast_resp = bastion_client.get_bastion(bastion_id=bast_id)
    api_bast = api_bast_resp.data

    # is it on the right subnet?
    subnet_id = security_bastion.outputs["test_subnet_id"]['value']
    assert api_bast.target_subnet_id == subnet_id

