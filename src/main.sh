#!/bin/bash

source src/functions.sh

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
		delete_by_id "${filenames[@]}"
		;;

	3)
		search_regex "${filenames[@]}"
		;;
	4)
		delete_log_data "${filenames[@]}"
		;;

	5)
		read -p "Select the file you would like to read: " id_to_read
		less ${filenames[$id_to_read]}
		;;

esac 
