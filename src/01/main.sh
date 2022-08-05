#!/bin/bash

. ./generator_part1.sh
. ./validator_part1.sh

# if path is not acceptable, files will not create
# size is only "kb", not "Kb" (look at readme)

if [[ $# -ne 6 ]]; then
    echo -e "\033[31mWrong number of parametrs"
    exit 1
fi

validator_part1 $1 $2 $3 $4 $5 $6
generator_part1 $1 $2 $3 $4 $5 $6
