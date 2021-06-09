#!/bin/bash
#-----------------------------------------------------------------------------
#
#		logger.sh
#
#		Utility to log messages.
#
#		What it does
#			- Logs the beginning of script
#			- Logs Metadata
#			- Logs Step
#			- Logs Checklist
#			- Logs Error
#			- Logs Exit
#			- Logs the end of script
#
#		Arguments:
#			1. scriptName -> Name of the script.
#			2. noInit -> Don't log the beginning of the script.
#
#-----------------------------------------------------------------------------

#
# Initialize
#
scriptName="$1"
noInit=$2
stepCounter=1
RESET_STYLE="\033[0m"
ERROR_STYLE="\033[0;31m"
STEP_STYLE="\033[1;34m"
BRIGHT_STYLE="\033[1;97m"
CHECK_STYLE="\033[0;32m"
UNCHECK_STYLE="\033[0;31m"

#-----------------------------------------------------------------------------

#
# Function logMeta
#
logMeta() {
	echo -e "$1: ${BRIGHT_STYLE}$2${RESET_STYLE}"
}

#
# Function logStep
#
logStep() {
	stepTitle=$1
	echo -e "\n${STEP_STYLE}$stepTitle ...${RESET_STYLE}"
	((stepCounter++))
}

#
# Function logCheck
#
logCheck() {
	echo -e "${CHECK_STYLE}[✓]${RESET_STYLE} $1"
}

#
# Function logUnCheck
#
logUnCheck() {
	echo -e "${UNCHECK_STYLE}[x]${RESET_STYLE} $1"
}

#
# Function logError
#
logError() {
	echo -e "${ERROR_STYLE}\n$1:\n$2${RESET_STYLE}"
}

#
# Function logExit
#
logExit() {
	scriptNameUpper=$(echo $scriptName | tr '[:lower:]' '[:upper:]')
	echo -e "${ERROR_STYLE}\n******** $scriptNameUpper EXITED WITH ERROR CODE: $1 ********${RESET_STYLE}"
}

#
# Function logShutdown
#
logShutdown() {
	echo -e "\n---- END OF SCRIPT $scriptName ----\n"
}

#-----------------------------------------------------------------------------
