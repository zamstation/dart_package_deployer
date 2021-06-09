#!/bin/bash
#-----------------------------------------------------------------------------
#
#		lint.sh
#
#		Script that lints the code.
#
#		Arguments:
#			1. buildDirectory
#
#-----------------------------------------------------------------------------

# Setup
set -e
scriptDirectory="$(dirname "$0")"
scriptName="$(basename "$0")"
errorList=("DART_FORMAT_ERROR")
utilitiesDirectory="$scriptDirectory/../utilities"
source "$scriptDirectory/logger.sh" $scriptName
source "$scriptDirectory/error_thrower.sh" $scriptName $errorList

# Initialize
buildDirectory="."
if [[ ! -z "$1" ]]; then
	buildDirectory="$1"
fi
cd "$buildDirectory"

#
# Linting Code
#
logStep "Linting Code"
echo "Running dart format ."
dart format .
exitCode=$?
if [[ exitCode -ne 0 ]]; then
	throwAndExit "DART_FORMAT_ERROR" "Error while running dart format"
fi

#
# Shutdown
#
cd -
exit 0

#-----------------------------------------------------------------------------
