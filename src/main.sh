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
		rm ${filenames[$id_to_delete]}	
	;;
esac 
