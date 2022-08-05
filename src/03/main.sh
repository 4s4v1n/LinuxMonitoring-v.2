#!/bin/bash

. ./clean_scripts.sh

if [[ $# -ne 1 ]]; then
    echo -e "\033[31mWrong number of parametrs"
    exit 1
fi

if [[ ! $1 =~ ^[[:digit:]] ]]; then
    echo -e "\033[31mMode must be a positive number"
    exit 1
fi 

if [[ $1 -lt 1 ]] || [[ $1 -gt 3 ]]; then
    echo -e "\033[31mWrong mode of script work"
    exit 1
fi

case $1 in
    1)  log_clean;;
    2)  date_clean;;
    3)  mask_clean;;
esac

if [[ -f "../02/02.log" ]]; then
    rm "../02/02.log"
fi
