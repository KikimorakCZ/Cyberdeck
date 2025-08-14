#!/data/data/com.termux/files/usr/bin/bash

function hacking_page_1() {
  while true; do
    clear
    echo "Hacking (Page 1)"
    echo
    echo "0) Basic port scan on IP"
    echo "1) Ping flood (LAN)"
    echo "2) Whois lookup"
    echo "3) Nmap scan on IP"
    echo "4) Show public IP"
    echo "5) LAN device scan (nmap)"
    echo "6) Reverse DNS (host)"
    echo "7) GeoIP lookup"
    echo "8) HTTP headers check"
    echo "9) More tools..."
    echo
    echo "x) Exit"
    echo "b) Back"
    echo "h#) Help (např. h7)"
    read -p "> " opt

    case $opt in
      0)
        read -p "Target IP: " ip
        logfile=~/hacks/cyberdeck/logs/scan_${ip}_$(date +%F_%H-%M).log
        for port in 21 22 23 25 53 80 443 8080; do
          timeout 1 bash -c "echo > /dev/tcp/$ip/$port" 2>/dev/null && echo "Port $port open" | tee -a "$logfile"
        done
        read -p "Stiskni enter pro pokračování..."
        ;;
      1)
        read -p "Target IP: " ip
        read -p "Ping count: " count
        ping -f -c $count $ip
        read -p "Stiskni enter pro pokračování..."
        ;;
      2)
        read -p "Domain/IP: " target
        whois $target | tee ~/hacks/cyberdeck/logs/whois_${target}_$(date +%F).log
        read -p "Stiskni enter pro pokračování..."
        ;;
      3)
        read -p "Target IP: " target
        nmap $target | tee ~/hacks/cyberdeck/logs/nmap_${target}_$(date +%F).log
        read -p "Stiskni enter pro pokračování..."
        ;;
      4)
        curl -s ifconfig.me
        echo
        read -p "Stiskni enter pro pokračování..."
        ;;
      5)
        net=$(ip addr show wlan0 | grep 'inet ' | awk '{print $2}')
        echo "Scanning $net..."
        nmap -sn $net | tee ~/hacks/cyberdeck/logs/lan_scan_$(date +%F).log
        read -p "Stiskni enter pro pokračování..."
        ;;
      6)
        read -p "Enter IP: " ip
        host $ip
        read -p "Stiskni enter pro pokračování..."
        ;;
      7)
        read -p "Enter IP or domain: " target
        curl -s ipinfo.io/$target
        echo
        read -p "Stiskni enter pro pokračování..."
        ;;
      8)
        read -p "Enter URL (https://...): " url
        curl -I "$url"
        read -p "Stiskni enter pro pokračování..."
        ;;
      9)
        bash ~/hacks/cyberdeck/h2.sh
        ;;
      h0)
        echo -e "\n[HELP 0] Basic Port Scan"
        echo "- Provádí jednoduchý test běžných portů (21, 22, 80, 443, ...)"
        echo "- Využívá /dev/tcp bez potřeby nmap"
        read -p "Stiskni enter..."
        ;;
      h1)
        echo -e "\n[HELP 1] Ping Flood"
        echo "- Odesílá velké množství pingů na cílovou IP"
        echo "- Může odhalit dostupnost nebo přetížit cílové zařízení"
        read -p "Stiskni enter..."
        ;;
      h2)
        echo -e "\n[HELP 2] Whois Lookup"
        echo "- Získá informace o registraci domény nebo IP"
        echo "- Obsahuje majitele, síťový rozsah, kontakt"
        read -p "Stiskni enter..."
        ;;
      h3)
        echo -e "\n[HELP 3] Nmap Scan"
        echo "- Pokročilé skenování portů pomocí nmap"
        echo "- Může odhalit služby, OS a zranitelnosti"
        read -p "Stiskni enter..."
        ;;
      h4)
        echo -e "\n[HELP 4] Show Public IP"
        echo "- Zobrazí tvoji veřejnou IP pomocí curl a služby ifconfig.me"
        read -p "Stiskni enter..."
        ;;
      h5)
        echo -e "\n[HELP 5] LAN Device Scan"
        echo "- Skenuje všechny aktivní zařízení v síti"
        echo "- Pomocí nmap -sn (ping sweep)"
        read -p "Stiskni enter..."
        ;;
      h6)
        echo -e "\n[HELP 6] Reverse DNS"
        echo "- Přeloží IP adresu zpět na doménové jméno (pokud existuje)"
        echo "- Pomocí nástroje host"
        read -p "Stiskni enter..."
        ;;
      h7)
        echo -e "\n[HELP 7] GeoIP Lookup"
        echo "- Získá lokaci IP pomocí ipinfo.io"
        echo "- Ukáže stát, město, ISP, organizaci"
        echo "- Pomáhá zjistit, odkud IP pochází"
        read -p "Stiskni enter..."
        ;;
      h8)
        echo -e "\n[HELP 8] HTTP Headers"
        echo "- Získá odpověď hlaviček webového serveru (např. server info, cache)"
        echo "- Užitečné pro zjištění typu webserveru, redirectů apod."
        read -p "Stiskni enter..."
        ;;
      h9)
        echo -e "\n[HELP 9] Další nástroje"
        echo "- Otevře druhou stránku s dalšími hacking nástroji"
        read -p "Stiskni enter..."
        ;;
      x|X)
        exit 0
        ;;
      b|B)
        return
        ;;
      *)
        echo "Neplatná volba"
        sleep 1
        ;;
    esac
  done
}

hacking_page_1
