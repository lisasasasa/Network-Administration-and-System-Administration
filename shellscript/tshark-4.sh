#!/bin/bash
tshark -r hw1-tshark.pcapng -qz io,stat,1,"SUM(frame.len)frame.len" | grep "<>"| sed 's_Dur|_Dur |_g'| sort -k 6nr -k 2n | head -n $1 | awk '{print $2}'
