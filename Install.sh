#!/bin/bash

# Funktion zur Installation des Nvidia-Treibers
install_nvidia_driver() {
    read -p "Möchten Sie den Nvidia-Treiber installieren? (J/n): " choice
    choice=${choice:-'J'}

    if [ "$choice" = "J" ] || [ "$choice" = "j" ]; then
        sudo ubuntu-drivers autoinstall
    else
        echo "Nvidia-Treiber wird nicht installiert."
    fi
}

echo "Starte das Post-Installations-Skript für Ubuntu..."

# Aktualisiere die Paketquellen
sudo apt-get update

# Installiere die gewünschten Pakete
sudo apt-get install -y gnome-shell-extensions gnome-shell-extension-desktop-icons-ng gnome-shell-extension-manager gnome-tweaks

# Installiere PyCharm über Snap
read -p "Möchten Sie PyCharm installieren? (J/n): " choice
choice=${choice:-'J'}

if [ "$choice" = "J" ] || [ "$choice" = "j" ]; then
    sudo snap install pycharm-community --classic
else
    echo "PyCharm wird nicht installiert."
fi

# Installiere den Nvidia-Treiber, wenn gewünscht
install_nvidia_driver

# Abschlussmeldung
echo "Die Installation ist abgeschlossen."

exit 0
