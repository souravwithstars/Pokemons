#! /bin/bash
source "../card_wrapper.sh"
source "../get_info.sh"
source "../datalist.sh"

function assert_expectation () {
    local expected_data="$1"
    local actual_data="$2"
    local result="FAIL"

    [[ ${expected_data} == ${actual_data} ]] && result="PASS" 

    echo ${result}
}

function test_add_name () {
    echo "Test for add_name"

    local record="1|bulbasaur|grass,poison|45|45|64|49|49|69"
    local expected_output=`cat test_files/exp_addname.html`
    
    add_name "${record}" "output.html" "../templates/card.html"
    local actual_output=`cat output.html`
    assert_expectation "${expected_output}" "${actual_output}"
    rm output.html
}

function test_add_types () {
    echo "Test for add_type"
    echo "_pokemon_types_" > output.html

    local record="1|bulbasaur|grass,poison|45|45|64|49|49|69"
    local expected_types="<div class='grass'>Grass</div> <div class='poison'>Poison</div> "
    
    add_types "${record}" "output.html"
    local actual_types=`cat output.html`
    assert_expectation "${expected_types}" "${actual_types}"
    rm output.html
}

function test_add_datalist () {
    echo "Test for add_datalist"
    echo -e "_data_list_\n_id_no_" > output.html
    
    local database="data.csv"
    local expected_datalist=`echo -e '<dl class="statistics"><div class=attribute><dt>Weight</dt><dd>85</dd></div><div class=attribute><dt>Base XP</dt><dd>62</dd></div><div class=attribute><dt>HP</dt><dd>39</dd></div><div class=attribute><dt>Attack</dt><dd>52</dd></div><div class=attribute><dt>Defence</dt><dd>43</dd></div><div class=attribute><dt>Speed</dt><dd>65</dd></div></dl>\n4'`

    add_datalist "${database}" "output.html" "4"
    local actual_datalist=`cat output.html`
    assert_expectation "${expected_datalist}" "${actual_datalist}"
    rm output.html
}

function test_generate_card () {
    echo "Test for generate_card"
    touch output.html
    local database="data.csv"
    local poke_id="1"
    local expected_card=`cat test_files/exp_card.html`

    generate_card "${database}" "${poke_id}" "output.html" "../templates/card.html"
    local actual_card=`cat output.html`

    assert_expectation "${expected_card}" "${actual_card}"
    rm output.html
}

function all_tests () {
    test_add_name
    test_add_types
    test_add_datalist 
    test_generate_card
}

all_tests