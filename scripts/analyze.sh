#!/bin/bash
#-----------------------------------------------------------------------------
#
#		analyze.sh
#
#		Script that analyzes the code.
#
#		Arguments:
#			1. buildDirectory
#
#-----------------------------------------------------------------------------

# Setup
set -e
scriptDirectory="$(dirname "$0")"
scriptName="$(basename "$0")"
errorList=("DART_ANALYZE_ERROR")
source "$scriptDirectory/logger.sh" $scriptName
source "$scriptDirectory/error_thrower.sh" $scriptName $errorList

# Initialize
buildDirectory="."
if [[ ! -z "$1" ]]; then
	buildDirectory="$1"
fi
cd "$buildDirectory"

#
# Analyzing Code
#
logStep "Analyzing Code"
echo "Running dart analyze --fatal-infos --fatal-warnings ."
dart analyze --fatal-infos --fatal-warnings .
exitCode=$?
if [[ exitCode -ne 0 ]]; then
	throwAndExit "DART_ANALYZE_ERROR" "Error while running dart analyze"
fi

#
# Shutdown
#
cd -
exit 0

#-----------------------------------------------------------------------------
