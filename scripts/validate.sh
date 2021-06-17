#!/bin/bash
#-----------------------------------------------------------------------------
#
#		validate.sh
#
#		Script that validates the build.
#
#		What it does:
#			- Checks if all the required directories exist
#			- Checks if all the required files exist
#			- Validates pubspec file
#
#		Arguments:
#			1. buildDirectory
#
#-----------------------------------------------------------------------------

#
# Setup
#
scriptDirectory="$(dirname "$0")"
scriptName="$(basename "$0")"
errorList=(
	"PUBSPEC_NOT_FOUND_ERROR"
	"FILE_NOT_FOUND_ERROR"
	"PUBSPEC_VALIDATION_ERROR"
)
source "$scriptDirectory/logger.sh" $scriptName
source "$scriptDirectory/error_thrower.sh" $scriptName $errorList

#
# Parse Arguments
#
buildDirectory="."
if [[ ! -z "$1" ]]; then
	buildDirectory="$1"
fi

#
# Initialize
#
logStep "Initializing"
logCd "$buildDirectory"
cd "$buildDirectory"

#
# Extracting package name from pubspec
#
logStep "Extracting package name from pubspec"

if [[ ! -f "pubspec.yaml" ]]; then
	throwAndExit "PUBSPEC_NOT_FOUND_ERROR" "pubspec.yaml file is not found in the root directory."
fi

packageName=$(grep "name:" "pubspec.yaml" | cut -d ":" -f2 | xargs)
logMeta "Package Name" "$packageName"

#
# Validating pubspec
#
logStep "Validating pubspec"

declare -A patterns
patterns=(
	["name"]="^name: $packageName$"
	["version"]="^version: \d+\.\d+\.\d+(?:[+-]\S+)?$"
	["description"]="^description: .{60,}$"
	["homepage"]="^homepage: https://zamstation.com$"
	["repository"]="^repository: https://github.com/zamstation/$packageName$"
	["environment"]="^environment:$"
	["environment-sdk"]="^  sdk: .+$"
)

for field in "${!patterns[@]}"; do
	matches=$(grep -cP "${patterns[$field]}" "pubspec.yaml")
	if [ $matches -eq 1 ]; then
		logCheck "$field"
	else
		logUnCheck "$field"
		throwAndExit "PUBSPEC_VALIDATION_ERROR" "$field field is invalid.\n\tExpected Format:${patterns[$field]}"
	fi
done

#
# Checking required files
#
logStep "Checking required files"

files=(
	"pubspec.yaml"
	"README.md"
	"CHANGELOG.md"
	"LICENSE"
	"example/lib/main.dart"
	"lib/$packageName.dart"
)

for file in ${files[@]}; do
	if [[ -f $file ]]; then
		logCheck "$file"
	else
		logUnCheck "$file"
		throwAndExit "FILE_NOT_FOUND_ERROR" "$file does not exist."
	fi
done

testFiles=(test/*_test.dart)
if [[ -f ${testFiles[0]} ]]; then
	logCheck "test/*_test.dart"
else
	logUnCheck "test/*_test.dart"
	throwAndExit "FILE_NOT_FOUND_ERROR" "No test files found."
fi

#
# Cleanup
#
logStep "Cleaning Up"
logCd -
cd -

#
# Shutdown
#
exit 0

#-----------------------------------------------------------------------------
