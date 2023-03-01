from pytest_terraform import terraform
import pytest

from test_helpers.network.nettest import NetTest

#unit tests for network module
@pytest.mark.unit
@terraform("network", scope="session")
def test_hub_internet(network):
    bastion_ip = network.outputs['bastion_ip']['value']

    n = NetTest(bastion_ip)
    print(f"Checking SSH Connection to bastion {bastion_ip}")
    assert n.check_ssh_connection()

@pytest.mark.unit
def test_hub_to_spoke_subnet001_ping(network):
    bastion_ip = network.outputs['bastion_ip']['value']
    private_test_node_ips = network.outputs['private_test_node_ips']['value']

    n = NetTest(bastion_ip)
    ip = private_test_node_ips[0]
    print(f"Pinging {ip} from bastion {bastion_ip}")
    assert n.ping_server(ip)

@pytest.mark.unit
def test_hub_to_spoke_subnet002_ping(network):
    bastion_ip = network.outputs['bastion_ip']['value']
    private_test_node_ips = network.outputs['private_test_node_ips']['value']

    n = NetTest(bastion_ip)
    ip = private_test_node_ips[1]
    print(f"Pinging {ip} from bastion {bastion_ip}")
    assert n.ping_server(ip)

@pytest.mark.unit
def test_hub_to_spoke_subnet003_ping(network):
    bastion_ip = network.outputs['bastion_ip']['value']
    private_test_node_ips = network.outputs['private_test_node_ips']['value']

    n = NetTest(bastion_ip)
    ip = private_test_node_ips[2]
    print(f"Pinging {ip} from bastion {bastion_ip}")
    assert n.ping_server(ip)
