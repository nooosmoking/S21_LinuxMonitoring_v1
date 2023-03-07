#!/bin/bash
chmod +rx color.sh output.sh param.conf 2>/dev/null
source ./color.sh
FILE=./param.conf

default1=0
default2=0
default3=0
default4=0

declare -a colour_short=(
    "column1_background"
    "column1_font_color"
    "column2_background"
    "column2_font_color"
)

get_color() {
    color_word=0
    case $1 in
    1) color_word="(white)";;
    2) color_word="(red)";;
    3) color_word="(green)";;
    4) color_word="(blue)";;
    5) color_word="(purple)";;
    6) color_word="(black)";;
    esac
    echo $color_word
}

if [ ! -f "$FILE" ]; then
    num=1
    for i in ${colour_short[@]}
    do
        eval $( printf $i=$num)
        let "num += 1"
    done
else
    source param.conf
    num=1
    for i in ${colour_short[@]}
    do
        data=`echo $`$i
        if [ -z `eval echo $data` ]; then
            eval $( printf default$num=1)
            eval $( printf $i=$num)
        elif [[ `eval echo $data` != [1-6] ]]; then
            echo "Incorrect parameter"
            exit
        fi
        let "num += 1"
    done
fi

if [[ $column1_background = $column1_font_color ]]; then
    if [[ $default1 = 1 && $default2 = 0 ]]; then
        column1_background=2
    fi
fi
if [[ $column1_background = $column1_font_color ]]; then
    if [[ $default1 = 0 && $default2 = 1 ]]; then
        column1_font_color=1
    fi
fi
if [[ $column2_background = $column2_font_color ]]; then
    if [[ $default3 = 1 && $default4 = 0 ]]; then
        column2_background=4
    fi
fi
if [[ $column2_background = $column2_font_color ]]; then
    if [[ $default3 = 0 && $default4 = 1 ]]; then
        column2_font_color=5
    fi
fi
if [[ $column1_background = $column1_font_color ]]  || [[ $column2_background = $column2_font_color ]]; 
then
    echo "Parameters shouldn't be equal"
    exit
fi

bg=1
num=1
for i in ${colour_short[@]}
do  
    data=`echo $`$i
    eval $( printf param$num=$(./color.sh $(eval echo $data) $bg))
    let "bg *= -1"
    let "num += 1"
done

./output.sh $param1 $param2 $param3 $param4 $NORMAL
echo
echo "Column 1 background = $( if [[ $default1 = 1 ]] ; then echo default ; else echo $column1_background ; fi ; ) $(get_color $column1_background)"
echo "Column 1 font color = $( if [[ $default2 = 1 ]] ; then echo default ; else echo $column1_font_color ; fi ; ) $(get_color $column1_font_color)"
echo "Column 2 background = $( if [[ $default3 = 1 ]] ; then echo default ; else echo $column2_background ; fi ; ) $(get_color $column2_background)"
echo "Column 2 font color = $( if [[ $default4 = 1 ]] ; then echo default ; else echo $column2_font_color ; fi ; ) $(get_color $column2_font_color)"