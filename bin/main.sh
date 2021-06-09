#!/bin/bash
#-----------------------------------------------------------------------------
#
#		main.sh
#
#		Script that creats workspace and copies deploy tools
#
#		What it does
#			- Removes any existing workspace
#			- Creates new workspace
#			- Copies deploy tools to the new workspace
#
#		Arguments: <none>
#
#-----------------------------------------------------------------------------

#
# Setup
#
set -e
scriptDir="$(dirname "$0")"
RESET_STYLE="\033[0m"
SUCCESS_STYLE="\033[1;32m"
STEP_STYLE="\033[1;34m"

#
# Initialize
#
workspace="workspace"
srcDir="$scriptDir/../lib/src"
keepFile=".keep"

#
# Clearing Any Previous Workspace
#
echo -e "\n${STEP_STYLE}Clearing Any Previous Workspace ...${RESET_STYLE}"
rm -rfv "$workspace"

#
# Creating Workspace
#
echo -e "\n${STEP_STYLE}Creating Workspace ...${RESET_STYLE}"
cp -r "$srcDir/$workspace" "$workspace"
mkdir -p "$workspace/code"
mkdir -p "$workspace/build"

chmod -R 750 $workspace

emptyDirs=("code" "build")
for dir in ${emptyDirs[@]}; do
	rm -rf "$workspace/$dir/$keepFile"
done

echo -e "workspace:"
ls -ltra "$workspace"

echo -e "\nworkspace/code:"
ls -ltra "$workspace/code"

echo -e "\nworkspace/build:"
ls -ltra "$workspace/build"

echo -e "\nworkspace/deploy/scripts:"
ls -ltra "$workspace/deploy/scripts"

echo -e "\n${SUCCESS_STYLE}Workspace Created Successfully.${RESET_STYLE}"

# End
exit 0
