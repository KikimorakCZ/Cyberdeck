#!/data/data/com.termux/files/usr/bin/bash
# WATCH MODE (wm.sh) – monitoruje příchozí spojení a upozorní na podezřelé IP

LOGFILE=~/cyberdeck/logs/watchmode.log
THRESHOLD=5         # kolik spojení za interval je podezřelých
INTERVAL=60         # interval ve vteřinách
WHITELIST=("127.0.0.1" "::1" "192.168.1.1")  # běžné IP, které ignorujeme

declare -A ipcount

mkdir -p "$(dirname "$LOGFILE")"
echo "[*] Watch Mode spuštěn – sleduji připojení..."
echo "Každých $INTERVAL sekund, práh: $THRESHOLD spojení"
echo "Loguje se do: $LOGFILE"
echo

while true; do
  timestamp=$(date "+%Y-%m-%d %H:%M:%S")
  ips=$(ss -tunp 2>/dev/null | awk 'NR>1 {print $5}' | cut -d':' -f1 | sort -u)

  for ip in $ips; do
    [[ -z "$ip" ]] && continue

    # whitelist kontrola
    for white in "${WHITELIST[@]}"; do
      [[ "$ip" == "$white" ]] && continue 2
    done

    ((ipcount["$ip"]++))
    echo "$timestamp - $ip" >> "$LOGFILE"

    if [[ ${ipcount["$ip"]} -eq $THRESHOLD ]]; then
      echo "[ALERT] $timestamp: $ip překročila $THRESHOLD spojení!"
      termux-notification \
        --title "CyberDeck Alert" \
        --content "IP $ip komunikovala $THRESHOLD× za posledních $INTERVAL s"
    fi
  done

  sleep $INTERVAL
  unset ipcount
  declare -A ipcount
done
