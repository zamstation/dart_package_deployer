#!/bin/bash
#-----------------------------------------------------------------------------
#
#		pack.sh
#
#		Script that packs the build.
#
#		What it does:
#			- Checks if all the required directories exist
#			- Checks if all the required files exist
#			- Validates pubspec file
#
#		Arguments:
#			1. codeDirectory
#			1. buildDirectory
#
#-----------------------------------------------------------------------------

# Setup
scriptDirectory="$(dirname "$0")"
scriptName="$(basename "$0")"
errorList=(
	"ARG_ERROR"
	"DIRECTORY_NOT_FOUND_ERROR"
	"FILE_NOT_FOUND_ERROR"
)
source "$scriptDirectory/logger.sh" $scriptName
source "$scriptDirectory/error_thrower.sh" $scriptName $errorList

# Initialize
if [[ -z "$1" || -z "$2" ]]; then
	throwAndExit "ARG_ERROR" "2 arguments required.\nArgument1: code directory\nArgument2: build directory"
fi
codeDirectory="$1"
buildDirectory="$2"
logMeta "Code Directory" "$codeDirectory"
logMeta "Build Directory" "$buildDirectory"

#
# Copying files to build directory
#
logStep "Copying files to build directory"

directories=(
	"example"
	"lib"
	"test"
)

for directory in ${directories[@]}; do
	if [[ -d "$codeDirectory/$directory" ]]; then
		echo "Copying $directory"
		cp -rf "$codeDirectory/$directory" "$buildDirectory"
	else
		throwAndExit "DIRECTORY_NOT_FOUND_ERROR" "$directory directory does not exist."
	fi
done

files=(
	"pubspec.yaml"
	"README.md"
	"CHANGELOG.md"
	"LICENSE"
)

for file in ${files[@]}; do
	if [[ -f "$codeDirectory/$file" ]]; then
		echo "Copying $file"
		cp -f "$codeDirectory/$file" "$buildDirectory"
	else
		throwAndExit "FILE_NOT_FOUND_ERROR" "$file does not exist."
	fi
done

#
# Showing Workspace
#
logStep "Showing Workspace"
echo "Build Directory:"
ls -ltra build

#
# Shutdown
#
exit 0

#-----------------------------------------------------------------------------
