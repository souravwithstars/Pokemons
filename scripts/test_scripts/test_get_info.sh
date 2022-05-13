#! /bin/bash
source "../get_info.sh"

function assert_expectation () {
    local expected_data="$1"
    local actual_data="$2"
    local result="FAIL"

    [[ ${expected_data} == ${actual_data} ]] && result="PASS" 

    echo ${result}
}

function test_get_field () {
    echo "Test for get_field"
    local record="1|bulbasaur|grass,poison|45|45|64|49|49|69"
    local field="2"
    local expected_data="bulbasaur"  

    actual_data=`get_field "${record}" "$field"`
    assert_expectation "${expected_data}" "${actual_data}"
}   

function test_get_pokemon_name () {
    echo "Test for get_pokemon_name"
    local record="5|charmeleon|fire|80|58|142|64|58|190"
    local expected_data="charmeleon"

    actual_data=`get_pokemon_name "${record}"`
    assert_expectation "${expected_data}" "${actual_data}"
}

function test_get_types () {
    echo "Test for get_types"
    local record="4|charmander|fire|65|39|62|52|43|85"
    local expected_data="<div class='fire'>Fire</div>"

    actual_data=`get_types "${record}"`
    assert_expectation "${expected_data}" "${actual_data}"
}

function test_get_record () {
    echo "Test for get_record"
    local pokemon_id="4"
    local database="data.csv"
    local expected_data="4|charmander|fire|65|39|62|52|43|85"

    actual_data=`get_record "${pokemon_id}" "${database}"`
    assert_expectation "${expected_data}" "${actual_data}"
}

function all_tests () {
    test_get_field
    test_get_pokemon_name
    test_get_types
    test_get_record
}

all_tests