#!/bin/bash
if [[ $# = 1 ]];
then
    reg="^[+,-]?[0-9]+([.][0-9]+)?$"
    if [[ $1 =~ $reg ]];
    then
        echo "Incorrect input";
    else 
        echo $1;
    fi
elif [[ $# > 1 ]];
then
    echo "Too many parameters";
elif [[ $# < 1 ]];
then
    echo "Should be one parameter";
fi