#!/bin/bash

. ../secondary_functions/secondary_functions.sh

function log_clean() {
    log_file="../02/02.log"
    if [[ ! -f $log_file ]];then 
        echo -e "\033[31mThere is no log file from 2-nd part"
        exit 1
    fi
    local remove_folders=$(grep '^.[^ ]*$' $log_file)
    for current_folder in $remove_folders
    do
        rm -rf $current_folder
    done
    echo -e "\033[32mCleaning by log file done"
}

function date_clean() {
    echo -n "Input date(DDMMYY): "
    read create_date
    date_valid $create_date
    echo -n "Input time when files creating starts(HH:MM): "
    read start_create
    time_valid $start_create
    echo -n "Input time when files creating ends(HH:MM): "
    read end_create
    time_valid $end_create
    create_date=${create_date: -2}-${create_date:2:2}-${create_date::2}
    start_create_hrs=${start_create::2}
    start_create_min=${start_create: -2}
    end_create_hrs=${end_create::2}
    end_create_min=${end_create: -2}
    if [[ ${start_create_hrs::1} -eq 0 ]]; then
        start_create_hrs=${start_create_hrs: -1}
    fi
    if [[ ${start_create_min::1} -eq 0 ]]; then
        start_create_min=${start_create_min: -1}
    fi
    if [[ ${end_create_hrs::1} -eq 0 ]]; then
        end_create_hrs=${end_create_hrs: -1}
    fi
    if [[ ${end_create_min::1} -eq 0 ]]; then
        end_create_min=${end_create_min: -1}
    fi
    if (( $start_create_min * 60 + $start_create_hrs > $end_create_min * 60 + $end_create_hrs )); then
        echo -e "\033[31mEnd can't be earlyer then a start"
        exit 1
    fi
    start_create=${start_create::2}:${start_create: -2}
    end_create=${end_create::2}:${end_create: -2}
    local remove_files=$(find /home -type f -newerct "$create_date $start_create:00" ! -newerct "$create_date $end_create:59")
    local remove_folders=$(find /home -type d -newerct "$create_date $start_create:00" ! -newerct "$create_date $end_create:59")
    for file in $remove_files
    do 
        if [[ ${file: -2} != "sh" ]]; then
            rm $file
        fi
    done

    for folder in $remove_folders
    do
        rmdir $folder 2>/dev/null
    done
    echo -e "\033[32mCleaning by date done!"
}

function mask_clean() {
    echo -n "Input mask for folders(symbols_date): "
    read mask
    mask_valid $mask
    local mask_letters=${mask%_*}
    local mask_date=${mask#*_}
    local remove_folders=$(find /home -type d -name "$mask_letters*_$mask_date")
    if [[ -z $remove_folders ]]; then
        echo -e "\033[31mThere is no such folders to clean"
        exit 1
    fi
    for folder in $remove_folders
    do
        rm -rf $folder
    done
    echo -e "\033[32mCleaning by mask done!"
}
