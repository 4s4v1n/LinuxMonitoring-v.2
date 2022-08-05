#!/bin/bash

filesPath="../04/*.log"

function sortByRequest() {
    awk '{print $0}' $filesPath | sort -nk 9
}

function uniqIP() {
    awk '{print $0}' $filesPath | sort -uk 1
}

function errorRequest() {
    awk '{ if( $9 ~/^[45]..$/ )print $0}' $filesPath
}

function uniqIPfromErrorRequest() {
    awk '{ if( $9 ~/^[45]..$/ )print $0}' $filesPath | sort -uk 1
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
