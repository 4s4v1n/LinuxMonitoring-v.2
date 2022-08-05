#!/bin/bash

. ../secondary_functions/secondary_functions.sh

function generator_part2() {
    all_paths=$(find /home -type d -perm -u=w,g=w 2>/dev/null ! \( -path "*/bin" -o -path "*/bin/*" -o -path "*/sbin" -o -path "*/sbin/*" \))
    dir_name_pattern=$1

    file_name_pattern=${2%.*}
    file_extension=${2#*.}
    file_size=${3::-2}

    current_date=$(date +"%d%m%y")

    while [[ ${#dir_name_pattern} -lt 5 ]]
    do
        dir_name_pattern=$dir_name_pattern${dir_name_pattern: -1}
    done
    dir_name=$dir_name_pattern

    while [[ ${#file_name_pattern} -lt 5 ]]
    do
        file_name_pattern=$file_name_pattern${file_name_pattern: -1}
    done
    file_name=$file_name_pattern

    time_start=$(date +%T)

    make_log 2

    for path in $all_paths
    do  
        for (( i = 0; i < 100; i++ ))
        do 
            full_path=$path/$dir_name
            make_dir $full_path\_$current_date 2
            while [[ $(( ${#file_name} + ${#current_date} + ${#file_extension} + 2 )) -lt 255 ]] # 2- lenght of "." and "_"
            do  
                size_left 2 $time_start
                make_file $full_path\_$current_date $file_name\_$current_date\.$file_extension $file_size M 2
                file_name=$file_name${file_name: -1}
            done
            dir_name=$dir_name${dir_name: -1}
            file_name=$file_name_pattern
        done 
        dir_name=$dir_name_pattern
    done
}




