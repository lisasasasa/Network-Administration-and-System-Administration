#!/bin/bash
tshark -r hw1-tshark.pcapng -Y "ip.src==$1" | wc -l
