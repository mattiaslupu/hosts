#!/bin/bash
INPUT_FILE="/etc/hosts"

while read -r line; do
    if [[ "$line" =~ ^# ]] || [[ -z "$line" ]]; then
        continue
    fi

    ip_addr=$(echo "$line" | awk '{print $1}')
    hostname=$(echo "$line" | awk '{print $2}')

    if [[ "$ip_addr" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        echo "Format valid: $ip_addr ($hostname)"
    else
        echo "Format invalid: $ip_addr"
    fi

done < "$INPUT_FILE"
