#!/bin/bash
WHITE='\033[37m'		
RED='\033[31m'			
GREEN='\033[32m'		
BLUE='\033[34m'			
PURPLE='\033[35m'		
BLACK='\033[30m'		

BGWHITE='\033[47m'		
BGRED='\033[41m'		
BGGREEN='\033[42m'		
BGBLUE='\033[44m'		
BGPURPLE='\033[45m'	    
BGBLACK='\033[40m'	

NORMAL='\033[0m'

case $2 in
    -1) case $1 in
        1) color=${WHITE};;
        2) color=${RED};;
        3) color=${GREEN};;
        4) color=${BLUE};;
        5) color=${PURPLE};;
        6) color=${BLACK};;
        esac;;
    1) case $1 in
        1) color=${BGWHITE};;
        2) color=${BGRED};;
        3) color=${BGGREEN};;
        4) color=${BGBLUE};;
        5) color=${BGPURPLE};;
        6) color=${BGBLACK};;
        esac
esac
if [[ $# = 2 ]]; then
    echo $color
fi
