#!/bin/bash
INPUT_FILE="/etc/hosts"
DNS_SERVER="8.8.8.8"

function valideaza_dns {
    local host=$1
    local ip=$2
    local dns=$3


    if host "$host" "$dns" | grep -q "$ip"; then
        echo "[DNS MATCH] $host rezolva la $ip folosind serverul $dns"
    else
        echo "[DNS MISMATCH] $host NU rezolva la $ip folosind serverul $dns (sau host inexistent)"
    fi
}


while read -r line; do
    if [[ "$line" =~ ^# ]] || [[ -z "$line" ]] || [[ "$line" =~ ^127\. ]] || [[ "$line" =~ ^::1 ]]; then
        continue
    fi

    current_ip=$(echo "$line" | awk '{print $1}')
    current_host=$(echo "$line" | awk '{print $2}')

    valideaza_dns "$current_host" "$current_ip" "$DNS_SERVER"

done < "$INPUT_FILE"
