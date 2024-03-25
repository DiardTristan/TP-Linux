#!/usr/bin/bash
#ChinoisEndurci33
#23/02/2024

space_var=0
number_1=0

echo "Machine name : $(hostname)"
source /etc/os-release
echo "OS : $(echo $NAME) and kernel version is $(echo $VERSION)"
echo "IP : $(ip a | grep "enp0s3" | head -n 2 | grep "inet" | tr -s " " | cut -d " " -f3)"
echo "RAM : $(free -mh | grep "Mem: " | tr -s ' ' | cut -d' ' -f2) memory available on $(echo free -mh | grep "Mem: " | tr -s ' ' | cut -d' ' -f7) total memory"
echo "Disk : $(df | grep "root" | tr -s " " | cut -d" " -f3) space left"
echo "Top 5 processes by RAM usage :"


while [[ ${number_1} -ne 5 ]]
do
  number_1=$(( number_1 + 1 ))
  echo " - $(ps aux --sort -rss | tail -n +2 | sed -n ${number_1}'p' | tr -s " " | cut -d" " -f11)  : $(ps aux --sort -rss | tail -n +2 | sed -n ${number_1}'p' | tr -s " " | cut -d" " -f4)%"
done

echo "Listening ports :"
ss -tulne | tail -n+2 | while read ss; do
    echo "      - $(echo "$ss" | tr -s ' ' | cut -d ' ' -f5 | grep -v "::" | cut -d ":" -f2) $( echo "$ss" | tr -s ' ' | grep -v "::" | cut -d ' ' -f1) : $(echo "$ss" | tr -s ' ' | cut -d ' ' -f9 | cut -d '/' -f3 | cut -d '.' -f1)"
done

echo "PATH directories :"
echo "$PATH" | tr ':' '\n' | while read -r directory; do
    echo -e " $directory\n"
done

echo "Here is your random cat (jpg file) : $( curl -s https://api.thecatapi.com/v1/images/search | cut -d '"' -f8) "