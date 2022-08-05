#!/bin/bash

function validator_part1() {
    if [[ ${1:0:1} != "/" ]]; then
        echo -e "\033[31mPath is not absoulute"
        exit 1
    fi

    if [[ ${1: -1} == "/" ]]; then
        echo -e "\033[31mThe path must not end with a character '/'"
        exit 1
    fi

    if [[ ! -d $1 ]]; then
        echo -e "\033[31mNot a catalog"
        exit 1
    fi

    if [[ ! $2 =~ ^[[:digit:]]+$ ]] || [[ $2 -eq 0 ]]; then
        echo -e "\033[31mWrong number of subcatalogs"
        exit 1
    fi

    if [[ $3 =~ ^[[:alpha:]]+$ ]]; then
        if [[ ${#3} -gt 7 ]]; then
            echo -e "\033[31mToo much letters in catalogs name"
            exit 1
        fi
    else
        echo -e "\033[31mWrong symbols for catalogs names"
        exit 1
    fi

    if [[ ! $4 =~ ^[[:digit:]]+$ ]] || [[ $4 -eq 0 ]]; then
        echo -e "\033[31mWrong number of files in subdirectories"
        exit 1
    fi

    if [[ $5 =~ ^[[:alpha:]]+\.[[:alpha:]]+ ]]; then
        name=${5%.*}
        extension=${5#*.}
        if [[ ${#name} -gt 7 ]] || [[ ${#extension} -gt 3 ]]; then
            echo -e "\033[31mWrong name pattern for files"
            exit 1
        fi
    else
        echo -e "\033[31mWrong name pattern for files"
        exit 1
    fi

    if [[ $6 =~ ^[[:digit:]]+kb$ ]]; then
        size=${6%kb*}
        if [[ $size -gt 100 ]] || [[ $size -eq 0 ]]; then
            echo -e "\033[31mWrong size of files"
            exit 1
        fi
    else
        echo -e "\033[31mWrong size of files"
        exit 1
    fi

}
