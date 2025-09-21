#!/bin/bash

update_sources_list() {
    local release=$1
    local codename

    case $release in
        "stable")
            codename="trixie"
            ;;
        "trixie")
            codename="forky"  #As of 2025, 'forky' is the codename for Debian 14 (testing)
            ;;
        "testing")
            codename="testing"
            ;;
        "sid")
            codename="sid"
            ;;
        *)
            echo "Invalid release selected. Choose 'stable', 'forky', 'testing', or 'sid'."
            exit 1
            ;;
    esac

    if [ "$codename" = "sid" ]; then
        sudo tee /etc/apt/sources.list > /dev/null <<EOF
deb http://deb.debian.org/debian/ $codename main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ $codename main contrib non-free non-free-firmware
EOF
    else
        sudo tee /etc/apt/sources.list > /dev/null <<EOF
deb http://deb.debian.org/debian/ $codename main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ $codename main contrib non-free non-free-firmware
deb http://security.debian.org/debian-security/ ${codename}-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security/ ${codename}-security main contrib non-free non-free-firmware
deb http://deb.debian.org/debian/ ${codename}-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ ${codename}-updates main contrib non-free non-free-firmware
EOF
    fi
}

echo "Which version of Debian do you want to use?"
echo "1. Stable (Trixie)"
echo "2. Testing (Forky)"
echo "3. Testing (Rolling)"
echo "4. Sid (Unstable)"
read -p "Choose (1, 2, 3, or 4): " choice

case $choice in
    1)
        update_sources_list "stable"
        ;;
    2)
        update_sources_list "forky"
        ;;
    3)
        update_sources_list "testing"
        ;;
    4)
        update_sources_list "sid"
        ;;
    *)
        echo "Invalid option. Please choose 1, 2, 3, or 4."
        exit 1
        ;;
esac

echo "Updating system to chosen version..."
sudo apt update
sudo apt upgrade -y
sudo apt full-upgrade -y

echo "System updated. Please reboot with: 'sudo reboot'"
