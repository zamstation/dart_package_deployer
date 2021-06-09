#!/bin/bash
#-----------------------------------------------------------------------------
#
#		publish.sh
#
#		Script that publishes the package to pub.dev
#
#		What it does
#			- Publishes package to pub.dev when env is test
#			- Dry runs when env is test
#
#		Arguments:
#			1. buildDirectory
#			2. env -> Environment - prod|test
#
#-----------------------------------------------------------------------------

#
# Setup
#
set -e
scriptDirectory="$(dirname "$0")"
scriptName="$(basename "$0")"
errorList=("DART_PUB_PUBLISH_ERROR")
source "$scriptDirectory/logger.sh" $scriptName
source "$scriptDirectory/error_thrower.sh" $scriptName $errorList

#
# Initialize
#
buildDirectory="."
if [[ ! -z "$1" ]]; then
	buildDirectory="$1"
fi
cd "$buildDirectory"
env='test'
if [[ $2 == 'prod' ]]; then
	env='prod'
fi
logMeta "Environment" $env

#
# Publishing package
#
logStep "Publishing Package"
if [[ $env == 'test' ]]; then
	echo "Running dart pub publish --dry-run"
	dart pub publish --dry-run
else
	echo 'Running dart pub publish'
	dart pub publish
fi
exitCode=$?
if [[ exitCode -ne 0 ]]; then
	throwAndExit "DART_PUB_PUBLISH_ERROR" "Error while running dart pub publish"
fi

#
# Shutdown
#
cd -
exit 0

#-----------------------------------------------------------------------------
