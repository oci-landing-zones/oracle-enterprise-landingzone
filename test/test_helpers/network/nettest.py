import socket
import paramiko

from .proxssh import ProxySSH

class NetTest:

    def __init__(self, bastion_ip):
        self.bastion_ip = bastion_ip

    def check_ssh_connection(self, server_ip=None):
        """Check ssh connection to server.
        If server_ip is not specified, check connection to bastion"""
        p = ProxySSH(self.bastion_ip, server_ip=server_ip)
        #try:
        p.exec_command_no_print("hostname")
        # except paramiko.SSHException:
        #     return False
        # except socket.timeout:
        #     return False
        return True

    def ping_server(self, destination_ip, source_ip=None):
        """Ping destination from source.
        If no source specified, use bastion"""
        p = ProxySSH(self.bastion_ip, server_ip=source_ip)
        #try:
        cmd =  f"ping -c 3 {destination_ip} ; echo $?"
        res = p.exec_command_no_print(cmd)
        errcode = res.splitlines()[-1]
        # except paramiko.SSHException:
        #     return False
        # except socket.timeout:
        #     return False
        return errcode == "0"
               

if __name__ == "__main__":
    n = NetTest("150.136.166.192")

    #n = NetTest("129.80.237.242")

    print("Checking Bastion SSH connection (port 22)...")
    assert n.check_ssh_connection()
    print(" Ok.")

    print("Pinging Server 1...")
    assert n.ping_server("10.0.1.54")
    print(" Ok.")

    print("Pinging Server 2...")
    assert n.ping_server("10.0.2.45")
    print(" Ok.")

    print("Pinging Server 3...")
    assert n.ping_server("10.0.3.117")
    print(" Ok.")
