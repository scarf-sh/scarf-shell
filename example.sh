#!/bin/bash

SCARF_BASE_URL="https://avi.gateway.scarf.sh/bash-test"
SCARF_PACKAGE_VERSION="0.1"

source ./scarf.sh
setup_scarf_telemetry

sleep 3
echo "Hello!"
