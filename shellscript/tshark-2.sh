#!/bin/bash
ans=$(tshark -r hw1-tshark.pcapng -Tfields -e frame.time_epoch -e ip.src -e ip.dst -e frame.len | sort -k 4,4nr -k 1,1n | head -n $1)
echo "$ans" | while read line; do
    arr=($line)
    day=$(date -d @${arr[0]} +"%F %T") 
    echo "$day,${arr[1]},${arr[2]}"
done 
