echo -e $1$2HOSTNAME =$5$3$4 $(hostname)$5
echo -e $1$2TIMEZONE =$5$3$4 $(timedatectl | grep 'Time zone: '| sed -e 's/,//' -e 's/0//' -e 's/(//'|awk '{printf "%s UTC %s", $3, $4}')$5
echo -e $1$2USER =$5$3$4 $(whoami)$5
echo -e $1$2OS =$5$3$4" $(cat /etc/issue | sed 's/ \\n \\l//')"$5
echo -e $1$2DATE =$5$3$4 $(date +"%d %b %Y %T")$5
echo -e $1$2UPTIME =$5$3$4 $(uptime -p| sed 's/up //')$5
echo -e $1$2UPTIME_SEC =$5$3$4  $(cat /proc/uptime | cut -d. -f1)$5
ip=$(ip a | grep "inet " | grep -v " lo" | grep -v "docker0" | sed 's/\/..//' | awk '{printf "%s ", $2}')
echo -e $1$2IP =$5$3$4 $ip$5
echo -e $1$2MASK =$5$3$4 $(ifconfig | grep $ip | awk '{printf "%s ", $4}')$5
echo -e $1$2GATEWAY =$5$3$4 $(ip route | grep default | awk '{printf "%s ", $3}')$5
echo -e $1$2RAM_TOTAL =$5$3$4 $(free -m | grep Mem | awk '{printf "%.3f GB", $2/1024}')$5
echo -e $1$2RAM_USED =$5$3$4  $(free -m | grep Mem | awk '{printf "%.3f GB", $3/1024}')$5
echo -e $1$2RAM_FREE =$5$3$4  $(free -m | grep Mem | awk '{printf "%.3f GB", $4/1024}')$5
echo -e $1$2SPACE_ROOT =$5$3$4 $(df -k /root/ | grep '/' | awk  '{printf "%.2f MB", $2/1024}')$5
echo -e $1$2SPACE_ROOT_USED =$5$3$4 $(df -k /root/ | grep '/' | awk  '{printf "%.2f MB", $3/1024}')$5
echo -e $1$2SPACE_ROOT_FREE =$5$3$4 $(df -k /root/ | grep '/' | awk  '{printf "%.2f MB", $4/1024}')$5


