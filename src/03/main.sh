#!/bin/bash
chmod +rx color.sh output.sh

source ./color.sh
if [[ $# > 4 ]];
then
    echo "Too many parameters";
elif [[ $# < 4 ]];
then
    echo "Should be 4 parameters";
elif [[ $# = 4 ]];
then
    for i in "$@"
    do
        if [[ $i != [1-6] ]]
        then
            echo "Incorrect input"
            exit
        fi
    done
    if [[ $1 = $2 ]] || [[ $3 = $4 ]]; 
    then
        echo "Parameters shouldn't be equal"
        exit
    fi
    bg=1
    num=1
    for i in "$@"
    do 
        eval $( printf param$num=$(./color.sh $i $bg))
        let "bg = bg * -1"
        let "num = num + 1"
    done
    ./output.sh $param1 $param2 $param3 $param4 $NORMAL

fi