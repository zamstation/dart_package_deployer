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
	"ARGUMENT_ERROR"
	"CODE_DIRECTORY_NOT_FOUND_ERROR"
	"DIRECTORY_NOT_FOUND_ERROR"
	"FILE_NOT_FOUND_ERROR"
)
source "$scriptDirectory/logger.sh" $scriptName
source "$scriptDirectory/error_thrower.sh" $scriptName $errorList

# Initialize
if [[ $1 == "--cleanup" ]]; then
	cleanup=true
	shift
fi
if [[ -z "$1" || -z "$2" ]]; then
	throwAndExit "ARGUMENT_ERROR" "  EXPECTED: [--cleanup] codeDirectory buildDirectory\n  PROVIDED: $@"
fi
codeDirectory="$1"
buildDirectory="$2"
logMeta "Code Directory" "$codeDirectory"
logMeta "Build Directory" "$buildDirectory"

#
# Copying files to build directory
#
logStep "Copying files to build directory"

if [[ ! -d "$codeDirectory" ]]; then
	throwAndExit "CODE_DIRECTORY_NOT_FOUND_ERROR" "'$codeDirectory' directory does not exist."
fi

echo -e "Creating Build Directory: $buildDirectory"
mkdir -p "$buildDirectory"

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
		throwAndExit "DIRECTORY_NOT_FOUND_ERROR" "'$directory' directory does not exist."
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
		throwAndExit "FILE_NOT_FOUND_ERROR" "'$file' file does not exist."
	fi
done

#
# Cleaning up
#
logStep "Cleaning up"
echo "Removing $codeDirectory"
rm -rf $codeDirectory

#
# Showing Build Directory
#
logStep "Showing Build Directory"
echo "Build Directory:"
ls -ltra "$buildDirectory"

#
# Shutdown
#
exit 0

#-----------------------------------------------------------------------------
