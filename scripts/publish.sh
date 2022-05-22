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
errorList=(
	"ARGUMENT_ERROR"
	"DART_PUB_PUBLISH_ERROR"
)
source "$scriptDirectory/logger.sh" $scriptName
source "$scriptDirectory/error_thrower.sh" $scriptName $errorList

#
# Parse Arguments
#
environment="test"
buildDirectory="."
while [[ $# -gt 0 ]]; do
	case $1 in
	-e | --env | --environment)
		environment="$2"
		shift
		shift
		;;
	-b | --buildDir | --buildDirectory)
		buildDirectory="$2"
		shift
		shift
		;;
	*)
		throwAndExit "ARGUMENT_ERROR" "  Expected: [--env environment] [--buildDir buildDirectory]\n  Provided: $@"
		;;
	esac
done
logMeta "Environment" $environment
logMeta "Build Directory" $buildDirectory

#
# Initialize
#
logStep "Initializing"
assetsDir="$scriptDirectory/../assets"
credentialsFile="credentials.json"
logCd "$buildDirectory"
cd "$buildDirectory"

#
# Publish
#
logStep "Publishing Package"
if [[ $environment == 'test' ]]; then
	echo "Running dart pub publish --dry-run"
	dart pub publish --dry-run
else
	mkdir -p "$PUB_CACHE"
	cat >$PUB_CACHE/credentials.json <<-EOF
		{
			"accessToken": "$PUB_ACCESS_TOKEN",
			"refreshToken": "$PUB_REFRESH_TOKEN",
			"tokenEndpoint": "https://accounts.google.com/o/oauth2/token",
			"scopes": [
				"https://www.googleapis.com/auth/userinfo.email",
				"openid"
			],
			"expiration": 1622902326632
		}
	EOF
	echo 'Running dart pub publish -f'
	curl "http://localhost:34075/?code=4%2F0AX4XfWgaLOZPc5EHootp0ONqhUB8BlwlakRhHDkur9q8RYeg_yEQepZ8L0trCOf0sZo8JQ&scope=email+openid+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email&authuser=0&prompt=consent"
	dart pub publish -f
fi
exitCode=$?
if [[ exitCode -ne 0 ]]; then
	throwAndExit "DART_PUB_PUBLISH_ERROR" "Error while running dart pub publish"
fi

#
# Cleanup
#
logStep "Cleaning Up"
logCd "-"
cd -

#
# Shutdown
#
exit 0

#-----------------------------------------------------------------------------
