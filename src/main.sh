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



if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

filenames=($(get_files_arr /var/log))


echo "**********************************************"
echo "*                                            *"
echo "* 1. Display all the log files               *"
echo "* 2. Delete a log file by its id             *"
echo "* 3. Search in a log file using regex        *"
echo "* 4. Delete lines from a logfile using regex *"
echo "* 5. Display a specific log file             *"
echo "* q. Exit                                    *"
echo "*                                            *"
echo "**********************************************"

read -p "Choose an option: " choice
    
case $choice in
	"q")
		echo "Closing the application"
		exit
		;;

	1)
		display_all "${filenames[@]}"
		;;

	2)
		read -p "Please select the file id to be deleted. HINT: You can look the IDs up using the first option: " id_to_delete 
	
		echo "Do you want to delete that file? (y/n)"
    		read confirm
    		if [[ "$confirm" == "y" ]]; then
        		echo "${filenames[$id_to_delete]} have been deleted."
			rm ${filenames[$id_to_delete]}	

    		else
        		echo "Deletion canceled."
    		fi


		;;

	3)
		read -p "Please select the file id to be searched. HINT: You can look the IDs up using the first option: " id_to_select 
		read -p "Please specify what you want to search: " search_regex

		less +/${search_regex} ${filenames[$id_to_select]}
		;;
	4)
		delete_log_data
		;;

	5)
		read -p "Select the file you would like to read: " id_to_read
		less ${filenames[$id_to_read]}
		;;

esac 
