#!/data/data/com.termux/files/usr/bin/bash

function security_and_control() {
  while true; do
    clear
    echo "Security and Control"
    echo
    echo "0) Show connected devices (ARP)"
    echo "1) Show open ports (netstat)"
    echo "2) Running processes"
    echo "3) WiFi signal (termux-api)"
    echo "4) Battery status (termux-api)"
    echo "5) System stats"
    echo
    echo "x) Exit"
    echo "b) Back"
    echo "h#) Help (např. h4)"
    read -p "> " opt

    case $opt in
      0)
        ip neigh
        read -p "Stiskni enter..."
        ;;
      1)
        if ! command -v netstat >/dev/null; then
          echo "netstat není dostupný."
        else
          netstat -tuln 2>/dev/null
        fi
        read -p "Stiskni enter..."
        ;;
      2)
        ps aux | head -n 25
        read -p "Stiskni enter..."
        ;;
      3)
        if ! command -v termux-wifi-connectioninfo >/dev/null; then
          echo "termux-api není nainstalováno."
        else
          termux-wifi-connectioninfo | grep -i signal
        fi
        read -p "Stiskni enter..."
        ;;
      4)
        if ! command -v termux-battery-status >/dev/null; then
          echo "termux-api není nainstalováno."
        else
          termux-battery-status
        fi
        read -p "Stiskni enter..."
        ;;
      5)
        echo "Uptime:"
        uptime
        echo
        echo "Top procesy:"
        top -bn1 | head -n 10
        read -p "Stiskni enter..."
        ;;
      h0)
        echo -e "\n[HELP 0] Show connected devices"
        echo "- ARP tabulka: ukáže připojená zařízení ve stejné síti."
        read -p "Stiskni enter..."
        ;;
      h1)
        echo -e "\n[HELP 1] Show open ports"
        echo "- Zobrazí otevřené porty běžících služeb (pokud netstat dostupný)."
        read -p "Stiskni enter..."
        ;;
      h2)
        echo -e "\n[HELP 2] Running processes"
        echo "- Výpis běžících procesů pro sledování aktivity systému."
        read -p "Stiskni enter..."
        ;;
      h3)
        echo -e "\n[HELP 3] WiFi signal"
        echo "- Ukáže sílu WiFi signálu (vyžaduje termux-api)."
        read -p "Stiskni enter..."
        ;;
      h4)
        echo -e "\n[HELP 4] Battery status"
        echo "- Ukáže stav baterie, nabití, teplotu (vyžaduje termux-api)."
        read -p "Stiskni enter..."
        ;;
      h5)
        echo -e "\n[HELP 5] System stats"
        echo "- Uptime, procesy a vytížení CPU/RAM (diagnostika)."
        read -p "Stiskni enter..."
        ;;
      x|X) exit 0 ;;
      b|B) return ;;
      *) echo "Neplatná volba"; sleep 1 ;;
    esac
  done
}

security_and_control
