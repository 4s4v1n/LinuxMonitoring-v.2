#!/bin/bash

. ./validator_part2.sh 
. ./generator_part2.sh

if [[ $# -ne 3 ]]; then
    echo -e "\033[31mWrong number of parametrs"
    exit 1
fi

validator_part2 $1 $2 $3
generator_part2 $1 $2 $3
