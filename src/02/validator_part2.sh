#!/bin/bash

function validator_part2() {
    if [[ $1 =~ ^[[:alpha:]]+$ ]]; then
        if [[ ${#1} -gt 7 ]]; then
            echo -e "\033[31mToo much letters in catalogs name"
            exit 1
        fi
    else
        echo -e "\033[31mWrong symbols for catalogs names"
        exit 1
    fi
    
    if [[ $2 =~ ^[[:alpha:]]+\.[[:alpha:]]+ ]]; then
        name=${2%.*}
        extension=${2#*.}
        if [[ ${#name} -gt 7 ]] || [[ ${#extension} -gt 3 ]]; then
            echo -e "\033[31mWrong name pattern for files"
            exit 1
        fi
    else
        echo -e "\033[31mWrong name pattern for files"
        exit 1
    fi
    
    if [[ $3 =~ ^[[:digit:]]+Mb$ ]]; then
        size=${3%Mb*}
        if [[ $size -gt 100 ]] || [[ $size -eq 0 ]]; then
            echo -e "\033[31mWrong size of files"
            exit 1
        fi
    else
        echo -e "\033[31mWrong size of files"
        exit 1
    fi       
}
