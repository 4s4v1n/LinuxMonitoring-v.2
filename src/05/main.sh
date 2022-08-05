#!/bin/bash

. ./analyzer.sh

if [[ $# -ne 1 ]]; then
    echo -e "\033[31mWrong number of parametrs"
    exit 1
fi

if [[ ! $1 =~ ^[1-4]$ ]]; then
    echo -e "\033[31mThere is no option like that"
    exit 1
fi

checkAllLogs

case $1 in
    1)  sortByRequest;;
    2)  uniqIP;;
    3)  errorRequest;;
    4)  uniqIPfromErrorRequest;;
esac