#! /bin/bash
source "scripts/general_functions.sh"

function create_dl_data () {
    local database="$1"
    local pokemon_id="$2"
    local field="$3"
    local attribute="$4"
    local stats=`grep "^${pokemon_id}|" <<< "${database}" | cut -d"|" -f "$field"`
    local dl_elements=`generate_dl_elements "${attribute}" "${stats}"`
    local dl_data=`generate_tag "div" "attribute" "${dl_elements}"`
    echo -n "${dl_data}"
}

function generate_datalist () {
    local database="$1"
    local pokemon_id="$2"
    local order=( 9_Weight "6_Base XP" 5_HP 7_Attack 8_Defence 4_Speed )
    local content=""

    for i in "${order[@]}"
    do
        local attribute=`echo ${i} | cut -d"_" -f2-`
        local field=`echo ${i} | cut -d"_" -f1`
        content+=`create_dl_data "${database}" "${pokemon_id}" "${field}" "${attribute}"`
    done
    local datalist=`generate_tag "dl" "statistics" "${content}"`
    echo -n "$datalist"
}

function add_name () {    
    local record="$1"
    local template="$2"
    local name=`get_pokemon_name "${record}"`
    local pokemon_name=`capitalize_data "${name}"`

    sed "s;_pokemon_img_;${name};g
         s;_pokemon_name_;${pokemon_name};g" <<< ${template}
}

function generate_types () {
    local record="$1"
    local types=(`get_field "${record}" 3`)
    IFS=','
    for type in ${types[@]}
    do
        local capitalize_type=`capitalize_data "${type}"`
        generate_tag "div" "${type}" "${capitalize_type}"
    done
}

function add_types () {
    local record="$1"
    local source_data="$2"
    local types=`generate_types "${record}"`
    local pokemon_types=`echo "${types}" | tr "\n" " " `
    local updated_types=`substitute "_pokemon_types_" "${pokemon_types}" "${source_data}"`
    echo "${updated_types}"
}

function add_datalist () {
    local database="$1"
    local source="$2"
    local id="$3"
    local datalist=`generate_datalist "${database}" "${id}"`

    sed "s;_id_no_;${id};g
         s;_data_list_;${datalist};g" <<< "${source}"
}  

function create_card () {
    local database="$1"
    local pokemon_id="$2"
    local template="$3"

    local record=`get_record ${pokemon_id} "${database}"`
    local update_name=`add_name "${record}" "${template}"`
    local update_type=`add_types "${record}" "${update_name}"`
    local update_datalist=`add_datalist "${database}" "${update_type}" "${pokemon_id}"`

    echo "${update_datalist}"
}

function generate_all_cards () {
    local database="$1"
    local total_ids=( $2 )
    local template="$3"
    for id in "${total_ids[@]}"
    do
        local card=`create_card "${database}" "${id}" "${template}"`
        echo ${card}
    done
}