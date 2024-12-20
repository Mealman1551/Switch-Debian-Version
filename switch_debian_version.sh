#!/bin/bash

# Functie om de sources.list bij te werken
update_sources_list() {
    local release=$1

    case $release in
        "stable")
            echo "Instellen naar Debian Stable (Bookworm)..."
            echo "deb http://deb.debian.org/debian/ stable main contrib non-free" | sudo tee /etc/apt/sources.list > /dev/null
            echo "deb-src http://deb.debian.org/debian/ stable main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            echo "deb http://security.debian.org/debian-security/ stable-security main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            echo "deb-src http://security.debian.org/debian-security/ stable-security main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            ;;
        "testing")
            echo "Instellen naar Debian Testing (Trixie)..."
            echo "deb http://deb.debian.org/debian/ trixie main contrib non-free" | sudo tee /etc/apt/sources.list > /dev/null
            echo "deb-src http://deb.debian.org/debian/ trixie main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            echo "deb http://security.debian.org/debian-security/ trixie-security main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            echo "deb-src http://security.debian.org/debian-security/ trixie-security main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            ;;
        "sid")
            echo "Instellen naar Debian Sid (Unstable)..."
            echo "deb http://deb.debian.org/debian/ sid main contrib non-free" | sudo tee /etc/apt/sources.list > /dev/null
            echo "deb-src http://deb.debian.org/debian/ sid main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            echo "deb http://security.debian.org/debian-security/ sid-security main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            echo "deb-src http://security.debian.org/debian-security/ sid-security main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            ;;
        *)
            echo "Ongeldige keuze. Kies 'stable', 'testing' of 'sid'."
            exit 1
            ;;
    esac
}

# Vraag de gebruiker om een keuze te maken
echo "Welke versie van Debian wil je gebruiken?"
echo "1. Stable (Bookworm)"
echo "2. Testing (Trixie)"
echo "3. Sid (Unstable)"
read -p "Voer je keuze in (1, 2, of 3): " keuze

# Pas de keuze toe op de sources.list
case $keuze in
    1)
        update_sources_list "stable"
        ;;
    2)
        update_sources_list "testing"
        ;;
    3)
        update_sources_list "sid"
        ;;
    *)
        echo "Ongeldige keuze. Kies 1, 2, of 3."
        exit 1
        ;;
esac

# Update en upgrade het systeem
echo "Bijwerken van je systeem naar de gekozen versie..."
sudo apt update
sudo apt upgrade -y
sudo apt full-upgrade -y

echo "Systeem succesvol bijgewerkt naar de gekozen versie. Herstart het systeem indien nodig."
