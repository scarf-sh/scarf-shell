# scarf-shell

A shell utility for adding Scarf analytics to any shell or bash script.

## Setup

You'll need a Scarf account and a File Package created. 

Note that backend URLs will not be relevant here as there is no redirect needed, but as of writing this README our UI requires them to set up a File Package. Put anything you want there, it will be discarded (eg, "https://not-needed.com").

Read more here: https://docs.scarf.sh

## Usage

```sh
# Your Scarf Gateway URL
SCARF_BASE_URL="https://avi.gateway.scarf.sh/bash-test"
# The version of your package, if any
SCARF_PACKAGE_VERSION="0.1"

# Source the scarf.sh script
source ./scarf.sh
# Initialize it
setup_scarf_telemetry

# Write your script as usual
```

## What gets sent

- The version of your script
- The platform your script is run on
- The elapsed time of your script
- The exit code

## Opting out of analytics as and end-user of your script

```sh
export SCARF_ANALYTICS=false
```
