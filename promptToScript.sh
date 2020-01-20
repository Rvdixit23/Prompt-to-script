#!/bin/bash
HISTFILE=~/.bash_history
set -o history
if[[ $1 -eq "-l" ]];then
    echo "Script based on number of lines"
    echo "Take file name as argument"
else if[[ $1 -eq "-c" ]];then
    echo "Script based on the passed command"
    echo "Take file name as argument"
    fi
fi
