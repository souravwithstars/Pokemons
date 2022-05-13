#! /bin/bash
source "scripts/general_functions.sh"

function generate_link () {
    local link="$1"
    local link_data="$2"
    
    echo "<a href=\"${link}\">${link_data}</a>"
}

function lists () {
    local pokemon_types=( $1 )
    local selected_type="$2"

    for type in ${pokemon_types[@]}
    do
        local class=""
        local anchor=`generate_link "${type}.html" "${type}" `
        if [[ ${type} == ${selected_type} ]] ; then
            class="${type} selected"
        fi
        local li_tag=`generate_tag "li" "${class}" "${anchor}"`
        echo -n "${li_tag}"
    done
}

function generate_sidebar () {
    local database=( $1 )
    local type="$2"

    local sidebar_data=`lists "${database[*]}" "${type}"`
    local ul_tag=`generate_tag "ul" "" "${sidebar_data}"`
    local sidebar=`generate_tag "nav" "sidebar" "${ul_tag}"`
    echo -n "${sidebar}"
}