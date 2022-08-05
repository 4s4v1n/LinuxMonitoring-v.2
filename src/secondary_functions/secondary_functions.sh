#!/bin/bash

function size_left() {
    if [[ $(df / | awk 'NR ==2{printf $4}') -le 1048576 ]]; then
        if [[ $1 -eq 2 ]];then 
            echo "Script start work at $2"
            echo "Script start work at $2" >> 02.log
            time_end=$(date +%T)
            echo "Script end work at $time_end"
            echo "Script end work at $time_end" >> 02.log
            start_seconds=$(echo $2 | sed -E 's/(.*):(.+):(.+)/\1*3600+\2*60+\3/;s/(.+):(.+)/\1*60+\2/' | bc) 
            end_seconds=$(echo $time_end | sed -E 's/(.*):(.+):(.+)/\1*3600+\2*60+\3/;s/(.+):(.+)/\1*60+\2/' | bc)
            echo "Script worked for $(( $end_seconds - $start_seconds )) seconds"
            echo "Script worked for $(( $end_seconds - $start_seconds )) seconds" >> 02.log
        fi
        echo -e "\033[31mSize in / is less then 1GB, script stops"
        exit 1
    fi
}

function make_file() { # 1-path, 2-file, 3-size 4-size extension 5-log number
    fallocate -l $3$4 $1/$2 2>/dev/null
    if [[ $? -eq 0 ]]; then
        echo -en ""$1"/"$2" "$3""$4"b\n" >> 0$5.log
    fi
}

function make_dir() { # 1-directory, 2-log number
    mkdir $1 2>/dev/null
    if [[ $? -eq 0 ]]; then
        echo -en "$1\n" >> 0$2.log
    fi
}

function make_log() { # 1-log file number
    if [[ ! -f 0$1.log ]]; then 
        touch 0$1.log
    fi
}

function date_valid() { #1-validation date
    if [[ ! $1 =~ ^[0-9]{6}$ ]]; then
        echo -e "\033[31mDate format is not correct"
        exit 1
    fi
    if [[ ${1::1} -ne 0 ]]; then
        if [[ ${1:: 2} -gt 31 ]]; then
            echo -e "\033[31mDate format is not correct"
            exit 1
        fi
    fi
    date "+%d%m%y" -d "$1" > /dev/null  2>/dev/null
    if [[ $? -ne 0 ]]; then
        echo -e "\033[31mDate format is not correct"
        exit 1
    fi
}

function time_valid() { # 1-validation time
    local delimeter=${1:2:1}
    if [[ $delimeter != ':' ]]; then
        echo -e "\033[31mWrong data format"
        exit 1
    fi
    if [[ ${#1} -ne 5 ]]; then
        echo -e "\033[31mWrong input data for time"
        exit 1
    fi
    local hours=${1::2}
    local minutes=${1: -2}
    if [[ $hours =~ ^[0-2][0-9]$ ]]; then
        if [[ ${hours::1} -eq 2 ]] && [[ ! ${hours: -1} =~ ^[0-3]$ ]]; then
            echo -e "\033[31mWrong input hours for time"
            exit 1
        fi
    else 
        echo -e "\033[31mWrong input hours for time"
        exit 1
    fi
    if [[ ! $minutes =~ ^[0-5][0-9]$ ]]; then
        echo -e "\033[31mWrong input minutes for time"
        exit 1
    fi
}

function mask_valid() { # 1-validation mask
    if [[ ${#1} -gt 14 ]] || [[ ${#1} -le 8 ]]; then
        echo -e "\033[31mMask has wrong size it can't be real mask"
        exit 1
    fi
    local mask_letters=${1%_*}
    local mask_date=${1#*_}
    if [[ ! $mask_letters =~ ^[[:alpha:]]*$ ]]; then
        echo -e "\033[31mLetters in mask are incorrect"
        exit 1
    fi
    date_valid $mask_date
}

function checkAllLogs() {
    local path="../04/0"
    local logPattern="nginx.log"
    for i in {1..5};
    do
    local log=$path$i$logPattern
        if [[ ! -f $log ]]; then
            echo -e "\033[31mThere is exists not all files from 4 part"
            exit 1
        fi
    done
}
