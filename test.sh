#!bin/bash

trim_string(){                                                                         
       trim=${1#${1%%[![:space:]]*}}
       trim=${trim%${trim##*[![:space:]]}}
       printf '%s\n' "$trim"
   }

packages=$(sed -e '/^$/ d' -e '/^#/ d' -e 's/#.*//' packages)
       while IFS=' ' read -r flag program comment; do
          program=$(trim_string "$program")
          echo "$program $flag"
       done <<EOF
   $packages
   EOF
