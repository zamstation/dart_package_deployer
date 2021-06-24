#!/bin/bash
#-----------------------------------------------------------------------------
#
#  compile.sh
#
#    Script that compiles the code.
#
#  Arguments:
#    1. buildDirectory
#
#-----------------------------------------------------------------------------

# Setup
set -e
scriptDirectory="$(dirname "$0")"
scriptName="$(basename "$0")"
errorList=("DART_PUB_GET_ERROR")
source "$scriptDirectory/logger.sh" $scriptName
source "$scriptDirectory/error_thrower.sh" $scriptName $errorList

# Initialize
buildDirectory="."
if [[ ! -z "$1" ]]; then
        buildDirectory="$1"
fi
cd "$buildDirectory"

#
# Getting Dependencies
#
logStep "Getting Dependencies"

echo "Running dart pub get"
dart pub get

exitCode=$?
if [[ exitCode -ne 0 ]]; then
        throwAndExit "DART_PUB_GET_ERROR" "Error while running dart pub get"
fi

#
# Shutdown
#
cd -
exit 0

#-----------------------------------------------------------------------------
