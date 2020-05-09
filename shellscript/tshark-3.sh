#!/bin/bash
tshark -r hw1-tshark.pcapng -Y dns -Tfields -e ip.src | tr "," " " | awk '{print $1}'| sort | uniq -c | sort -t' ' -k 1rn -k 2| head -n $1 | awk '{print $2","$1}'
