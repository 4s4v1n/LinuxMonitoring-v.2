#!/bin/bash

. ../secondary_functions/secondary_functions.sh

function generator_part1() {
    file_name_pattern=${5%.*}
    file_extension=${5#*.}
    file_size=${6::-2}

    dir_name=$3
    current_date=$(date +"%d%m%y")

    make_log 1

    while [[ ${#dir_name} -lt 4 ]]
    do
        dir_name=$dir_name${dir_name: -1}
    done

    while [[ ${#file_name_pattern} -lt 4 ]]
    do
        file_name_pattern=$file_name_pattern${file_name_pattern: -1}
    done

    for (( i=1; i<=$2; i++ ))
    do
        make_dir $1/$dir_name\_$current_date 1
        file_name=$file_name_pattern
        for (( j=1; j<=$4; j++ ))
        do
            size_left 1
            make_file $1/$dir_name\_$current_date $file_name\_$current_date\.$file_extension $file_size K 1
            file_name=$file_name${file_name: -1} 
        done
        dir_name=$dir_name${dir_name: -1}
    done
}
