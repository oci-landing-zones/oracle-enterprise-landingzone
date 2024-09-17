# Contributing to the project

Oracle welcomes contributions to this repository from anyone.

If you want to submit a pull request to fix a bug or enhance an existing
feature, please first open an issue and link to that issue when you
submit your pull request.

If you have any questions about a possible submission, feel free to open
an issue too.

## Contributing code

Before submitting code via a pull request, you will need to have signed 
the [Oracle Contributor Agreement][OCA] (OCA) and your commits need to 
include the following line using the name and e-mail address you used to 
sign the OCA:

```text
Signed-off-by: Your Name <you@example.org>
```

This can be automatically added to pull requests by committing with `--sign-off`
or `-s`, e.g.

```text
git commit --signoff
```

Only pull requests from committers that can be verified as having signed the OCA
can be accepted.

## Pull request process

1. Fork this repository
1. Create a branch in your fork to implement the changes. We recommend using
the issue number as part of your branch name, e.g. `1234-fixes`
1. Ensure that there is at least one test that would fail without the fix and
passes post fix
1. Submit the pull request. *Do not leave the pull request blank*. Explain exactly
what your changes are meant to do and provide simple steps on how to validate
your changes, ideally referencing the test. Ensure that you reference the issue
you created as well. We will assign the pull request to 1-2 people for review
before it is submitted internally and the PR is closed.

## Code of conduct

Follow the [Golden Rule](https://en.wikipedia.org/wiki/Golden_Rule). If you'd
like more specific guidelines, see the [Contributor Covenant Code of Conduct][COC].

## License

Copyright (c) 2022,2023 Oracle and/or its affiliates.

Licensed under the Universal Permissive License (UPL), Version 1.0.

See [LICENSE](./LICENSE.txt) for more details.

[OCA]: https://oca.opensource.oracle.com
[COC]: https://www.contributor-covenant.org/version/1/4/code-of-conduct/

