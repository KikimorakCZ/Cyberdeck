#!/data/data/com.termux/files/usr/bin/bash
# Plugin Manager – CyberDeck

PLUGINS_DIR=~/cyberdeck/plugins

while true; do
  clear
  echo "=== Plugin Manager ==="
  echo

  # Seznam pluginů
  i=0
  unset PLUGIN_FILES
  for file in "$PLUGINS_DIR"/*.sh; do
    [ -e "$file" ] || continue
    PLUGIN_FILES[$i]="$file"
    name=$(basename "$file" .sh)
    echo "$i) $name"
    ((i++))
  done

  echo
  echo "x) Exit"
  echo "b) Back"
  echo
  read -p "> " choice

  if [[ "$choice" == "x" || "$choice" == "X" ]]; then
    exit 0
  elif [[ "$choice" == "b" || "$choice" == "B" ]]; then
    break
  elif [[ "$choice" =~ ^h[0-9]+$ ]]; then
    index="${choice:1}"
    plugin="${PLUGIN_FILES[$index]}"
    if [[ -f "$plugin" ]]; then
      desc=$(grep -m1 '^# desc:' "$plugin" | sed 's/^# desc:[[:space:]]*//')
      clear
      echo
      echo "[$index] $plugin:"
      echo "${desc:-Žádný popis.}"
      echo
      read -p "[Enter] Pokračuj"
      clear
    else
      echo "Neplatné číslo pluginu."
      sleep 1
    fi
  elif [[ "$choice" =~ ^[0-9]+$ ]]; then
    plugin="${PLUGIN_FILES[$choice]}"
    if [[ -f "$plugin" ]]; then
      clear
      bash "$plugin"
      echo
      read -p "Stiskni Enter pro návrat do Plugin Manageru..."
      clear
    else
      echo "Neplatné číslo pluginu."
      sleep 1
    fi
  else
    echo "Neplatná volba."
    sleep 1
  fi
done
