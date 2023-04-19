from pytest_terraform import terraform
import pytest
import oci


from test_helpers.oci import get_test_config

#unit tests for vault/key portion of the security module
@pytest.mark.skip(reason="Skipped until we can better deal with vault cleanup. ")
@pytest.mark.unit
@pytest.mark.expensive
@terraform("security_vault", scope="session")
def test_master_encryption_key_created(security_vault):
    conf = get_test_config()
    #oci.key_management.KmsVaultClient(conf)

    vault = security_vault["oci_kms_vault.vault"]
    mgmt_url = vault["management_endpoint"]

    assert key_id is not None

    key_client =  oci.key_management.KmsManagementClient(conf, mgmt_url)
    key_id = security_vault.outputs["key_id"]
    k = key_client.get_key(key_id).data
    kv = key_client.get_key_version(key_id, k["current_key_version"]).data

    assert kv['lifecycle_state'] == "ACTIVE"
 
