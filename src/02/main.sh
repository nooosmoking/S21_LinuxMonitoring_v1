#!/bin/bash
cd $(dirname $0)
touch output.txt

echo HOSTNAME = $(hostname) | tee -a output.txt
echo TIMEZONE = $(timedatectl | grep 'Time zone: '| sed -e 's/,//' -e 's/0//' -e 's/(//'|awk '{printf "%s UTC %s", $3, $4}') | tee -a output.txt
echo USER = $(whoami) | tee -a output.txt
echo OS = $(cat /etc/issue | sed 's/ \\n \\l//') | tee -a output.txt
echo DATE = $(date +"%d %b %Y %T") | tee -a output.txt
echo UPTIME = $(uptime -p)| sed 's/up //'| tee -a output.txt
echo UPTIME_SEC =  $(cat /proc/uptime | cut -d. -f1) | tee -a output.txt
ip=$(ip a | grep "inet " | grep -v " lo" | grep -v "docker0" | sed 's/\/..//' | awk '{printf "%s ", $2}')
echo IP = $ip | tee -a output.txt
echo MASK = $(ifconfig | grep $ip | awk '{printf "%s ", $4}') | tee -a output.txt
echo GATEWAY = $(ip route | grep default | awk '{printf "%s ", $3}') | tee -a output.txt
echo RAM_TOTAL = $(free -m | grep Mem | awk '{printf "%.3f GB", $2/1024}') | tee -a output.txt
echo RAM_USED =  $(free -m | grep Mem | awk '{printf "%.3f GB", $3/1024}') | tee -a output.txt
echo RAM_FREE =  $(free -m | grep Mem | awk '{printf "%.3f GB", $4/1024}') | tee -a output.txt
echo SPACE_ROOT = $(df -k /root/ | grep '/' | awk  '{printf "%.2f MB", $2/1024}') | tee -a output.txt
echo SPACE_ROOT_USED = $(df -k /root/ | grep '/' | awk  '{printf "%.2f MB", $3/1024}') | tee -a output.txt
echo SPACE_ROOT_FREE = $(df -k /root/ | grep '/' | awk  '{printf "%.2f MB", $4/1024}') | tee -a output.txt

echo "Write down results in file? (Y/N)"
read answer
if [[ $answer == y ]] || [[ $answer == Y ]]
then
    cp output.txt $(date +"%d_%m_%y_%H_%M_%S").status;
fi
rm output.txt