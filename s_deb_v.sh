#!/bin/bash

update_sources_list() {
    local release=$1

    case $release in
        "stable")
            echo "Switching to Debian Stable (Bookworm)..."
            echo "deb http://deb.debian.org/debian/ stable main contrib non-free" | sudo tee /etc/apt/sources.list > /dev/null
            echo "deb-src http://deb.debian.org/debian/ stable main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            echo "deb http://security.debian.org/debian-security/ stable-security main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            echo "deb-src http://security.debian.org/debian-security/ stable-security main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            ;;
        "testing")
            echo "Switching to Debian Testing (Trixie)..."
            echo "deb http://deb.debian.org/debian/ trixie main contrib non-free" | sudo tee /etc/apt/sources.list > /dev/null
            echo "deb-src http://deb.debian.org/debian/ trixie main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            echo "deb http://security.debian.org/debian-security/ trixie-security main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            echo "deb-src http://security.debian.org/debian-security/ trixie-security main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            ;;
        "sid")
            echo "Switching to Debian Sid (Unstable)..."
            echo "deb http://deb.debian.org/debian/ unstable main contrib non-free" | sudo tee /etc/apt/sources.list > /dev/null
            echo "deb-src http://deb.debian.org/debian/ unstable main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            echo "deb http://security.debian.org/debian-security/ unstable-security main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            echo "deb-src http://security.debian.org/debian-security/ unstable-security main contrib non-free" | sudo tee -a /etc/apt/sources.list > /dev/null
            ;;
        *)
            echo "No such command found. choose 'stable', 'testing' of 'sid'."
            exit 1
            ;;
    esac
}

echo "Which version of Debian do you want to use?"
echo "1. Stable (Bookworm)"
echo "2. Testing (Trixie)"
echo "3. Sid (Unstable)"
read -p "Choose (1, 2, of 3): " keuze

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
        echo "No such command found. choose 1, 2, of 3."
        exit 1
        ;;
esac

# Update en upgrade het systeem
echo "Updating system to choosen version..."
sudo apt update
sudo apt upgrade -y
sudo apt full-upgrade -y

echo "System updated, please reboot with: 'sudo reboot'"
