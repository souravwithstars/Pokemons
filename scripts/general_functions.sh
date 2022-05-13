#! /bin/bash
function generate_html () {
    local title="$1"
    local body_content="$2"
    echo "<html><head><title>${title}</title><link rel=\"stylesheet\" href=\"style.css\"></head><body>${body_content}</body></html>"
}

function generate_tag {
    local tag="$1"
    local class="$2"
    local content="$3"    
    echo "<${tag} class=\"${class}\">${content}</${tag}>"
}

function generate_dl_elements () {
    local dt_data="$1"
    local dd_data="$2"

    echo "<dt>${dt_data}</dt><dd>${dd_data}</dd>"
}

function get_field () {
    local record="$1"
    local field="$2"
    cut -d"|" -f${field} <<< "${record}"
}

function get_pokemon_name () {
    local record="$1"
    get_field "${record}" 2
}

function get_record () {
    local poke_id="$1"
    local database="$2"
    grep "^${poke_id}|" <<< "${database}"
}

function get_types () {
    local database="$1"
    tail +2 "${database}" | cut -d"|" -f3 | tr "," "\n" | sort | uniq
}

function capitalize_data () {
    local data="$1"
    echo -n "${data:0:1}" | tr "[:lower:]" "[:upper:]"
    echo "${data:1}"
}

function substitute () {
    local pseudo_word="$1"
    local actual_data="$2"
    local template="$3"

    sed "s;${pseudo_word};${actual_data};g" <<< ${template}
}