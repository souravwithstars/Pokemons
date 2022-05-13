#! /bin/bash
source "scripts/sidebar.sh" 
source "scripts/generate_card.sh" 

function create_html () {
    local output_file="$1"
    local database="$2"
    local template="$3"
    local sidebar_data="$4"
    local type="$5"
    local total_ids=( `cut -d "|" -f1 <<< "${database}"` )

    local sidebar=`generate_sidebar "${sidebar_data}" "${type}"`
    local card=`generate_all_cards "${database}" "${total_ids[*]}" "${template}"`
    local main=`generate_tag "main" "card-wrapper" "${card}"`
    local page_wrapper=`generate_tag "div" "page-wrapper" "${sidebar} ${main}"`
    local html=`generate_html "Pokemon" "${page_wrapper}"`

    echo "${html}" > ${output_file}
}

function generate_all_html () {
    local database="$1"
    local template="$2"
    local html_dir="$3"

    local pokemon_types=( all `get_types "${database}"` )
    local template_data=`cat "${template}"`

    echo -e "\nCreating html files....\n"
    for type in ${pokemon_types[@]}
    do
        local types_data=`tail +2 "${database}"`
        local output_file="${html_dir}/${type}.html"
        echo "Creating ${type}.html"

        if [[ "$type" != "all" ]] ;then
            types_data=`grep "${type}" "${database}"`
        fi
        create_html "${output_file}" "${types_data}" "${template_data}" "${pokemon_types[*]}" "${type}"
    done
}