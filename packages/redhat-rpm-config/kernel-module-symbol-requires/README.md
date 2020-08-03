# packages/redhat-rpm-config/kernel-module-symbol-requires test
Test for BZ#1619235 (Incorrect kernel module symbol Requires generation)
Test Maintainer: [Eva Mrakova](mailto:emrakova@redhat.com)

## How to run it
Please refer to the top-level README.md for common dependencies.

### Install dependencies
```bash
root# bash ../../../cki_bin/pkgs_install.sh metadata
```

### Execute the test
```bash
bash ./runtest.sh
```
