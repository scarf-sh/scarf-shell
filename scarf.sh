# Capture the exit code
EXIT_CODE=0

# Scarf telemetry function
setup_scarf_telemetry() {
    # Define the base URL

    # Capture the script start time
    SCRIPT_START_TIME_MS=$(date +%s)

    # Ensure SCARF_BASE_URL is set
    if [ -z "${SCARF_BASE_URL}" ]; then
        echo "Error: no SCARF_BASE_URL is set"
        return 1
    fi

    # Warn if no SCARF_PACKAGE_VERSION is set
    if [ -z "${SCARF_PACKAGE_VERSION}" ]; then
        echo "Warning: no SCARF_PACKAGE_VERSION is set"
    fi

    # Function to send telemetry data
    send_telemetry() {
        # Check if SCARF_ANALYTICS is set to FALSE, if so, user has opted out.
        if [ "${SCARF_ANALYTICS}" = "FALSE" ]; then
            return 0
        fi

        # Capture the platform
        PLATFORM=$(uname -s)

        # Calculate the elapsed time
        END_TIME=$(date +%s)
        ELAPSED_TIME=$((($END_TIME - $SCRIPT_START_TIME_MS)))

        # Capture the version, if set
        local VERSION=${VERSION:-"unknown"}

        # Construct the POST request
        local DATA="platform=$PLATFORM&elapsed_time=$ELAPSED_TIME&exit_code=$EXIT_CODE&version=$VERSION"

        # Check if curl is on the machine. Silenty abort if no curl is found
        if ! command -v curl >/dev/null 2>&1; then
            echo "Error: curl is not installed or not found in PATH" >&2 exit 1
        fi

        curl --connect-timeout 3 -X POST "$SCARF_BASE_URL?$DATA"
    }

    # Ensure EXIT_CODE is set to the result of the trapped command, and send the telemetry data
    trap 'EXIT_CODE=$? && send_telemetry' EXIT
}

# Example usage:
# source /path/to/scarf_telemetry.sh # Import this at the beginning of your script
# ... # your script logic here
