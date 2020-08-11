# packages/iotop/sanity test
Verify that iotop can detect heavy disk load simulated by dd(1).
Test Maintainer: [Ales Zelinka](mailto:azelinka@redhat.com) 

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