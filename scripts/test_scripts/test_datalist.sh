#! /bin/bash
source "../datalist.sh"

function test_create_attributes () {
    local test_name="Should create given attribute with data"
    local database="data.csv"
    local poke_id="1"
    local field="9"
    local attribute="Weight" 
    local expected_attribute="<div class=attribute><dt>Weight</dt><dd>69</dd></div>"  

    local actual_attribute=`create_attributes "${database}" "${poke_id}" "${field}" "${attribute}"`
    assert_expectation "create_attributes" "${test_name}" "${expected_attribute}" "${actual_attribute}"
}   

function test_generate_datalist () {
    local test_name="Should generate datalist for given Pokemon id"
    local database="data.csv"
    local poke_id="1"
    local expected_datalist="`cat test_files/exp_datalist.html`"

    actual_datalist=`generate_datalist "${database}" "${poke_id}"`
    assert_expectation "generate_datalist" "${test_name}" "${expected_datalist}" "${actual_datalist}"
}

function datalist_testcases () {
    test_create_attributes
    test_generate_datalist
}
