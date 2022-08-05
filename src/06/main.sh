#!/bin/bash

# for install goaccess use "sudo apt-get update && sudo apt-get install goaccess"
# server running on localhost:5050

. ../secondary_functions/secondary_functions.sh

if [[ $# -ne 0 ]]; then
    echo -e "\033[31mScript work without parametrs, wrong input"
    exit 1
fi

checkAllLogs

all_logs="../04/*.log"

goaccess $all_logs -o report.html --log-format=COMBINED
python3 -m http.server 5050

# to stop and restart python server use kill -KILL