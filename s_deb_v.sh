#!/bin/bash

# Functie om de sources.list aan te passen
update_sources_list() {
    local release=$1
    local codename

    # Verkrijg de codenaam van de release
    case $release in
        "stable")
            codename="bookworm"
            echo "Switching to Debian Stable (Bookworm)..."
            ;;
        "testing")
            codename="trixie"
            echo "Switching to Debian Testing (Trixie)..."
            ;;
        "sid")
            codename="unstable"
            echo "Switching to Debian Sid (Unstable)..."
            ;;
        *)
            echo "No such command found. choose 'stable', 'testing' of 'sid'."
            exit 1
            ;;
    esac

    # Werk de /etc/apt/sources.list bij voor de geselecteerde release
    sudo tee /etc/apt/sources.list > /dev/null <<EOF
deb http://deb.debian.org/debian/ $codename main contrib non-free
deb-src http://deb.debian.org/debian/ $codename main contrib non-free
deb http://security.debian.org/debian-security/ ${codename}-security main contrib non-free
deb-src http://security.debian.org/debian-security/ ${codename}-security main contrib non-free
deb http://deb.debian.org/debian/ ${codename}-updates main contrib non-free
deb-src http://deb.debian.org/debian/ ${codename}-updates main contrib non-free
EOF
}

# Gebruiker om input vragen voor de versie die ze willen gebruiken
echo "Which version of Debian do you want to use?"
echo "1. Stable (Bookworm)"
echo "2. Testing (Trixie)"
echo "3. Sid (Unstable)"
read -p "Choose (1, 2, or 3): " keuze

# Pas de sources.list aan op basis van de keuze van de gebruiker
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
        echo "Invalid option. Please choose 1, 2, or 3."
        exit 1
        ;;
esac

# Update en upgrade het systeem
echo "Updating system to chosen version..."
sudo apt update
sudo apt upgrade -y
sudo apt full-upgrade -y

echo "System updated, please reboot with: 'sudo reboot'"
