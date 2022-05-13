#! /bin/bash

function apply_template() {
  template=$1
  name=$2
  gender_prefix=$3

  sed "s/__NAME__/${name}/" $template  | sed "s/__GENDER_PREFIX__/${gender_prefix}/"
}

function create_invitations() {
  invitees=$1
  template=$2

  OLDIFS=$IFS
  IFS=$'\n'
  for i in `cat ${invitees}`; do
    prefix=$(echo $i | cut -d',' -f1)
    name=$(echo $i | cut -d',' -f2)
    filename=$(echo $i | cut -d',' -f3)
    apply_template $template $name $prefix > "html/${filename}.html"
  done
  IFS=$OLDIFS
}

create_invitations "invitees.csv" "invitation.html"