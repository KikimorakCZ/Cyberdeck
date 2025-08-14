# CyberDeck

CyberDeck je balík shell skriptů pro Linux, Termux (Android) a iSH (iOS), který umožňuje spouštět různé nástroje a utilitky z jednoho místa snadno a rychle.

---

## Funkce
- 8+ shell skriptů pro různé účely
- Jednoduché spouštění skriptů přes `start.sh`
- Automatické nastavení spustitelných práv (`chmod +x`)
- Snadné kopírování skriptů do složky Downloads (Termux)
- Funguje na Linuxu, Termuxu i iSH

---

## Instalace

### Linux / iSH (iOS)
1. Naklonuj repozitář:
```sh
git clone https://github.com/USERNAME/CyberDeck.git
cd CyberDeck

2. Nastav spustitelná práva pro všechny skripty:



chmod +x *.sh

3. Spusť hlavní startovací skript:



./start.sh

### Termux (Android)

1. Ujisti se, že máš přístup k úložišti:



termux-setup-storage

2. Naklonuj repozitář:



git clone https://github.com/USERNAME/CyberDeck.git
cd CyberDeck

3. Spusť startovací skript:



./start.sh


---

## Doporučené balíčky

"menu and help" > "required packages"


---

## Poznámky

iSH: Přístup k souborům je omezen na /mnt, například iCloud Drive.

Termux: Kopírování do /sdcard/Download funguje jen po povolení přístupu k úložišti.

Skripty jsou určeny pro vzdělávací a osobní použití.