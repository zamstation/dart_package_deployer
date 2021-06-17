#!/bin/bash
#-----------------------------------------------------------------------------
#
#		test.sh
#
#		Script that tests the package and collects coverage.
#
#		Arguments:
#			1. buildDirectory
#
#-----------------------------------------------------------------------------

#
# Setup
#
set -e
scriptDirectory="$(dirname "$0")"
scriptName="$(basename "$0")"
errorList=("TEST_ERROR")
source "$scriptDirectory/logger.sh" $scriptName
source "$scriptDirectory/error_thrower.sh" $scriptName $errorList

# Initialize
buildDirectory="."
if [[ ! -z "$1" ]]; then
	buildDirectory="$1"
fi
cd "$buildDirectory"

#
# Running Tests and Collecting Coverage
#
logStep "Running Tests"
echo "Running dart test"
dart test
exitCode=$?
if [[ exitCode -ne 0 ]]; then
	throwAndExit "TEST_ERROR" "Error while running tests"
fi

#
# Shutdown
#
cd -
exit 0

#-----------------------------------------------------------------------------
