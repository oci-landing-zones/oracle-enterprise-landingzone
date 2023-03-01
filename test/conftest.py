from glob import glob
import os
import pytest
import shutil

@pytest.fixture(scope='session', autouse=True)
def session_setup_teardown():
    # setup code goes here if needed
    # copy common files to ./terraform/ subfolders then cleanup common files
    cwd = os.path.abspath(os.path.dirname(__file__))
    src = cwd + "/provider.tf"
    dsts = glob(cwd + "/terraform/*/")

    for dst in dsts:
        shutil.copy(src, dst)

    yield

    for dst in dsts:
        os.remove(dst + "provider.tf")
