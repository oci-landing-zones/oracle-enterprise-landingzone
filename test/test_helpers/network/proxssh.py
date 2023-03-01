import paramiko


class ProxySSH:

    def __init__(self, bastion_ip, server_ip=None, timeout=60):
        if server_ip is None:
            server_ip = bastion_ip

        self.server_ip = server_ip
        self.connect_timeout = timeout

        if bastion_ip == server_ip:
            self.bastion_ip = None
        else:
            self.bastion_ip = bastion_ip

        self._bastion_client = None
        self._server_client = None

    def open_client(self):
        server_client = paramiko.SSHClient()
        server_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

        if self.bastion_ip is None:
            self._bastion_client = None
            server_client.connect(self.server_ip, 
                                  username='opc',
                                  timeout=self.connect_timeout)
        else:
            bastion_client = paramiko.SSHClient()
            bastion_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            bastion_client.connect(self.bastion_ip, 
                                   username='opc',
                                   timeout=self.connect_timeout)
            self._bastion_client = bastion_client

            bastion_clienttransport = bastion_client.get_transport()
            bastion_clientchannel = bastion_clienttransport.open_channel("direct-tcpip",
                                                                        (self.server_ip, 22),
                                                                        (self.bastion_ip, 22))

            server_client.connect(self.server_ip, 
                                  username='opc', 
                                  timeout=self.connect_timeout,
                                  sock=bastion_clientchannel)

        self._server_client = server_client
        return server_client

    @property
    def server_client(self):
        if self._server_client is None:
            self.open_client()
        return self._server_client

    def close(self):
        if self._server_client is not None:
            self._server_client.close()
            self._server_client = None
        if self._bastion_client is not None:
            self._bastion_client.close()
            self._bastion_client = None

    @property
    def file_xfer(self):
        return self.server_client.open_sftp()

    def exec_command(self, cmd, display=True):
        if display:
            print("===== Running on {} =======".format(self.server_ip))
            print("       {}".format(cmd))
        stdin, stdout, stderr = self.server_client.exec_command(cmd)
        if display:
            print("-------- output -----------")
        stdout_return = stdout.read().decode('UTF-8')
        if display:
            print(stdout_return)
            print("-------- errors -----------")

            print(stderr.read().decode("UTF-8"))
            print("---------------------------")
        return stdout_return

    def exec_command_no_print(self, cmd):
        return self.exec_command(cmd, display=False)