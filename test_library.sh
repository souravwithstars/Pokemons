#! /bin/bash

source "scripts/generate_htmls.sh"

PASS_COUNT=0
FAIL_COUNT=0
DIR="scripts/test_scripts"

GREEN="\033[0;32m"
RED="\033[1;31m"
NOCOLOR="\033[0;0m"

FAIL_CASE_FUNCTION=()
FAIL_CASE_SCENARIO=()
FAIL_CASE_EXPECTED=()
FAIL_CASE_ACTUAL=()

function handle_fail_case() {
	local function_name=$1
	local test_scenario=$2
	local expected_data=$3
	local actual_data=$4

	FAIL_CASE_FUNCTION[$FAIL_COUNT]="${function_name}"
	FAIL_CASE_SCENARIO[$FAIL_COUNT]="${test_scenario}"
	FAIL_CASE_EXPECTED[$FAIL_COUNT]="${expected_data}"
	FAIL_CASE_ACTUAL[$FAIL_COUNT]="${actual_data}"
	
	FAIL_COUNT=$(( $FAIL_COUNT + 1 ))
}

function display_fail_cases() {
	for index in `seq 0 $(( ${FAIL_COUNT} - 1 ))`
	do
		echo -e "-------------------\n"	
		echo -e "${FAIL_CASE_FUNCTION[$index]}"
		echo -e "\t${FAIL_CASE_SCENARIO[$index]}"
		echo -e "expected:\n\n${RED}${FAIL_CASE_EXPECTED[$index]}\n${NOCOLOR}"
		echo -e "actual:\n\n${RED}${FAIL_CASE_ACTUAL[$index]}\n\n${NOCOLOR}"
	done
}

function assert_expectation () {
    local function_name="$1"
	local test_scenario="$2"
    local expected_data="$3"
    local actual_data="$4"
    local result="${RED}✗"

    if [[ "${actual_data}" != "${expected_data}" ]]
	then 
		echo -e "${NOCOLOR}\t${result} ${test_scenario}${NOCOLOR}"
		handle_fail_case ${function_name} "${test_scenario}" "${expected_data}" "${actual_data}"
		return
	fi
		
	result="${GREEN}✔" ; PASS_COUNT=$(( ${PASS_COUNT} + 1 )) ;
	echo -e "${NOCOLOR}\t${result} ${NOCOLOR}${test_scenario}" ; 

}

function test_cases() {
    # echo -e "\nCreate HTMLs"
	# source "${DIR}"/test_integrated.sh
    # integrated_testcases
    
    echo -e "\nGenerate Sidebar"
	source "${DIR}"/test_sidebar.sh
    sidebar_testcases
    
	# echo -e "\nData list"
	# source "${DIR}"/test_datalist.sh
    # datalist_testcases
	
}

function generate_report() {
	
	test_cases
	
	if [[ ${FAIL_COUNT} -ne 0 ]]
	then
	    echo -e "\n${RED}Failing test cases${NOCOLOR} : "
	    display_fail_cases
	fi		
	
	TOTAL_COUNT=$(( ${PASS_COUNT} + ${FAIL_COUNT} ))
	echo -e "\n--------------------\nFailing tests : ${FAIL_COUNT}/${TOTAL_COUNT}\n\n"
}

generate_report