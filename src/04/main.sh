#!/bin/bash

. ./log_generator.sh

if [[ $# -ne 0 ]]; then
    echo -e "\033[31mScript work without parametrs, wrong input"
    exit 1
fi

log_generator
