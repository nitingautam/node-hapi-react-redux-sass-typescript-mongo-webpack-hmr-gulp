#!/bin/sh

set -e

IMPORT_PATH="${BASH_SOURCE%/*}"
if [[ ! -d "$IMPORT_PATH" ]]; then IMPORT_PATH="$PWD"; fi
source "$IMPORT_PATH/helpers.sh"

# Start Slenium server.
run "npm run test-selenium-start --silent"

# Start Chromedriver server.
run "npm run test-chromedriver-start --silent"

# Start Test.
run "node ./test/webdriver.js" &
PERF_PID=$!
echo $?

wait $PERF_PID

run "npm run test-chromedriver-stop"
run "npm run test-selenium-stop"