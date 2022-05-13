#! /bin/bash
source "../integrated.sh"
source "../sidebar.sh"
source "../card_wrapper.sh"
source "../get_info.sh"
source "../datalist.sh"

function test_create_sidebar () {
    touch output.html

    local test_name="Should create sidebar for given html type"
    local data="data.csv"
    local type="grass"
    local expected_sidebar=`cat test_files/exp_created_sidebar.html`

    create_sidebar "output.html" "${data}" "${type}"
    local actual_sidebar=`cat output.html`
    assert_expectation "create_sidebar" "${test_name}" "${expected_sidebar}" "${actual_sidebar}"
    rm output.html
}

function test_create_card () {
    touch output.html
    
    local test_name="Should create card for given id"
    local database="data.csv"
    local ids="1"
    local template="../templates/card.html"
    local expected_card=`cat test_files/exp_created_card.html`
    create_card "output.html" "${database}" "${ids}" "${template}"
    local actual_card=`cat output.html`
    assert_expectation "create_card" "${test_name}" "${expected_card}" "${actual_card}"
    rm output.html
}

function test_create_html () {
    touch output.html
    
    local test_name="Should create html of each type"
    local database="data.csv"
    local template="../templates/card.html"
    local expected_html=`cat test_files/exp_integrated.html`
    create_html "output.html" "${database}" "${template}" "${database}" "all"
    local actual_html=`cat output.html`
    assert_expectation "create_html" "${test_name}" "${expected_html}" "${actual_html}"
    rm output.html
}

function test_generate_all_html () {
    mkdir "test_html"

    local test_name="Should create all html files"
    local database="data.csv"
    local template="../templates/card.html"
    local directory="test_html"
    local expected_htmls=`echo -e 'all.html\nfire.html\ngrass.html\npoison.html'`

    generate_all_html "${database}" "${template}" "${directory}"

    local actual_htmls=`ls test_html`
    assert_expectation "generate_all_html" "${test_name}" "${expected_htmls}" "${actual_htmls}"
    rm -r "test_html"
}


function integrated_testcases () {
    test_create_sidebar
    test_create_card
    test_create_html
    test_generate_all_html
}

