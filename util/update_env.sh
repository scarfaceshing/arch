#!/bin/bash

update_env() {
    local -r variable=$1
    local -r old_value=$(cat variable.conf | grep "$variable" | cut -d'=' -f2)
    local -r new_value=$2

    if [[ -f "variable.conf" ]]; then
        if  [[ $( cat variable.conf | grep "$variable=" ) ]]; then
            sed -i "s|'$variable=$old_value'|$variable=$new_value|g" variable.conf
        else
            echo "$variable=$new_value" >> variable.conf
        fi
    else
        echo "$1=$2" >> variable.conf
    fi
}