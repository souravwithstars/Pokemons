#! /bin/bash

function test_lists () {
    echo "Test for lists"
    local database=( fire grass poison )
    local expected_list='<li class=""><a href="fire.html">fire</a></li><li class=""><a href="grass.html">grass</a></li><li class="poison selected"><a href="poison.html">poison</a></li>'

    local actual_list=`lists "${database[*]}" "poison"`
    assert_expectation "lists" "Should create a list of given types" "${expected_list}" "${actual_list}"
}

function test_generate_sidebar () {
    local database=( $1 )
    local test_case="$2"
    local expected_sidebar="$3"
    local type="$4"

    actual_sidebar=`generate_sidebar "${database[*]}" "${type}"`
    assert_expectation "generate_sidebar" "${test_case}" "${expected_sidebar}" "${actual_sidebar}"
}

function generate_sidebar_testcases () {
    local exp_sidebar='<nav class="sidebar"><ul class=""><li class="all selected"><a href="all.html">all</a></li><li class=""><a href="fire.html">fire</a></li><li class=""><a href="grass.html">grass</a></li><li class=""><a href="poison.html">poison</a></li></ul></nav>'
    test_generate_sidebar "all fire grass poison" "When selected type is all" "${exp_sidebar}" "all"
    
    exp_sidebar='<nav class="sidebar"><ul class=""><li class=""><a href="all.html">all</a></li><li class="fire selected"><a href="fire.html">fire</a></li><li class=""><a href="grass.html">grass</a></li><li class=""><a href="poison.html">poison</a></li></ul></nav>'
    test_generate_sidebar "all fire grass poison" "When selected type is other than all" "${exp_sidebar}" "fire"
}

function sidebar_testcases () {
    test_lists
    generate_sidebar_testcases 
}