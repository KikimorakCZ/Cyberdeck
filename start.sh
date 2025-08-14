#!/data/data/com.termux/files/usr/bin/bash
# CyberDeck – GUI menu

# Kontrola, zda je Termux:GUI nainstalován
if ! command -v termux-gui >/dev/null 2>&1; then
    echo "Termux:GUI není nainstalován. Spouštím klasické textové menu..."
else
    # GUI menu
    run_mah() { bash ~/hacks/cyberdeck/mah.sh; }
    run_sac() { bash ~/hacks/cyberdeck/sac.sh; }
    run_h1() { bash ~/hacks/cyberdeck/h1.sh; }
    run_plugins() { bash ~/hacks/cyberdeck/plugins.sh; }
    run_wm() { bash ~/hacks/cyberdeck/wm.sh; }

    termux-gui <<EOF
CyberDeck Control Center
------------------------
[Menu and Help] → run_mah
[Security and Control] → run_sac
[Hacking] → run_h1
[Plugins] → run_plugins
[Watch mode] → run_wm
[Exit] → exit
EOF
    exit 0
fi

# Pokud GUI není dostupné, spustí se klasické textové menu
while true; do
  clear
  echo "=== CyberDeck Control Center ==="
  echo
  echo "1) Menu and Help"
  echo "2) Security and Control"
  echo "3) Hacking"
  echo "4) Plugins"
  echo "5) Watch mode"
  echo
  echo "x) Exit"
  echo
  read -p "> " choice

  case "$choice" in
    1) bash ~/hacks/cyberdeck/mah.sh ;;
    2) bash ~/hacks/cyberdeck/sac.sh ;;
    3) bash ~/hacks/cyberdeck/h1.sh ;;
    4) bash ~/hacks/cyberdeck/plugins.sh ;;
    5) bash ~/hacks/cyberdeck/wm.sh ;;
    x|X)
      echo "Ukončuji CyberDeck. 👋"
      exit 0
      ;;
    *)
      echo "Neplatná volba."
      sleep 1
      ;;
  esac
done
