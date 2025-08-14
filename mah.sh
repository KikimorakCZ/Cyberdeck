#!/data/data/com.termux/files/usr/bin/bash

function menu_and_help() {
  while true; do
    clear
    echo "Menu and Help"
    echo
    echo "0) Required packages"
    echo "1) Credits"
    echo "2) Launch count"
    echo "3) Help system tutorial"
    echo
    echo "x) Exit"
    echo "b) Back"
    read -p "> " opt

    case $opt in
      0)
        echo
        echo "Pro instalaci všech požadovaných balíčků použij:"
        echo "pkg update && pkg install bash coreutils whois curl termux-api nmap inetutils net-tools dnsutils"
        read -p "Stiskni enter pro pokračování..."
        ;;
      1)
        echo "Created by Lukas Kutaj"
        read -p "Stiskni enter pro pokračování..."
        ;;
      2)
        count_file=~/hacks/cyberdeck/launch_count.txt
        count=$(cat "$count_file")
        echo "Tento nástroj byl spuštěn $count krát."
        read -p "Stiskni enter pro pokračování..."
        ;;
      3)
        echo -e "\nHelp system tutorial:"
        echo "Ve všech kategoriích můžeš napsat 'h' + číslo (např. h0)."
        echo "To zobrazí nápovědu k dané volbě."
        echo "Pomůže ti to pochopit, co nástroj dělá, jak ho používat a k čemu slouží."
        read -p "Stiskni enter pro pokračování..."
        ;;
      x|X) exit 0 ;;
      b|B) return ;;
      *) echo "Neplatná volba"; sleep 1 ;;
    esac
  done
}

menu_and_help
