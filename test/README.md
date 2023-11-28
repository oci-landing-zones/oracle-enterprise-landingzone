# Testing Code

Unit and functional test code goes here. 

## Testing Locally
install the dependencies in a virtual environment
```bash
python -m venv lz-venv
. lz-venv/bin/activate
pip install -r test/requirements.txt
```

Edit and source the test_vars.example file
```
source test_vars
```

Run the tests
```
pytest test
```

Run a specific test script
```
pytest  --tf-mod-dir=test/terraform/budget test/test_budget.py
```

Run all unit tests
```
pytest -m unit test
```

To see the output of Terraform as it runs (for debugging),
you can use the `--capture=tee-sys` flag like so: 

```
pytest --capture=tee-sys --tf-mod-dir=test/terraform/budget test/test_budget.py
```
You can also add the `--pdb` flag to pytest to drop into the python debugger within a failed test. 

# License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](./LICENSE) for more details.
