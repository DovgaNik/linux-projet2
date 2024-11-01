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

delete_log_data() {
    local filenames=("$@") 
    read -p "Select the file you would like to delete the lines from: " id_log_file 
    selected_log_file=${filenames[$id_log_file]}
    read -p "Enter the text or pattern to search for: " pattern

    matches=$(grep -n "$pattern" "$selected_log_file")
    if [[ -z "$matches" ]]; then
        echo "No matches found."
        return
    fi

    echo "The following lines match your search pattern:"
    echo "$matches"

    echo "Do you want to delete these lines? (y/n)"
    read confirm
    if [[ "$confirm" == "y" ]]; then
        sed -i "/$pattern/d" "$selected_log_file"
        echo "Lines containing '$pattern' have been deleted."
    else
        echo "Deletion canceled."
    fi
}

delete_by_id () {
	local filenames=("$@") 
	read -p "Please select the file id to be deleted. HINT: You can look the IDs up using the first option: " id_to_delete 
	
	echo "Do you want to delete that file? (y/n)"
    	read confirm
    	if [[ "$confirm" == "y" ]]; then
       		echo "${filenames[$id_to_delete]} have been deleted."
		rm ${filenames[$id_to_delete]}	
    	else
        	echo "Deletion canceled."
    	fi
}

search_regex () { 

	local filenames=("$@") 
	read -p "Please select the file id to be searched. HINT: You can look the IDs up using the first option: " id_to_select 
	read -p "Please specify what you want to search: " search_regex

	less +/${search_regex} ${filenames[$id_to_select]}


}

open_file () {
	local filenames=("$@") 
	read -p "Select the file you would like to read: " id_to_read
	less ${filenames[$id_to_read]}
}
