#!/bin/bash

get_files_arr () {
    folder_path=$1
    find "$folder_path" -type f
}

display_all () {
    local filenames=("$@") 
    counter=0
    echo "Displaying all the files available in /var/log/"
    for filename in "${filenames[@]}"; do
        echo "$counter: $filename" 
        ((counter++))
    done
}

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

filenames=($(get_files_arr /var/log))

display_all "${filenames[@]}"
