import json
import base64
import os

if __name__ == '__main__':
    output = "{\"output\": \"NO_DATA\"}"
    filePath = "./ag_si_creation_response.txt"
    if os.stat(filePath).st_size != 0:
        file = open(filePath)
        line = file.readline()
        service_instance_data = base64.b64decode(line)
        json_data = json.loads(json.loads(service_instance_data))
        si_ocid = json_data["id"]
        if not si_ocid:
            si_ocid = "dummy"
        output = "{\"output\": \"" + si_ocid + "\"}"
    print(output)
