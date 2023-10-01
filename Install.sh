#!/bin/bash

#
#    Gnome Shell Settings
#

run_gnome_extension_config() {
    name="$1"
    folder="$2"
    xml="$3"

    read -p "Soll $name konfiguriert werden? (J/n): " choice
    choice=${choice:-'J'}
    if [ "$choice" = "J" ] || [ "$choice" = "j" ]; then
        cat "preconfig/$xml" >> "~/.local/share/gnome-shell/extensions/${folder}/schemas/${xml}"
        sudo glib-compile-schemas "~/.local/share/gnome-shell/extensions/${folder}/schemas"
        echo "$name konfiguriert! \n\n"
    else
        echo "Nvidia-Treiber wird nicht installiert."
    fi
    
    cat a >> b
}

read -p "Sollen gnome-tweaks Konfiguriert werden? (J/n): " choice
choice=${choice:-'J'}
if [ "$choice" = "J" ] || [ "$choice" = "j" ]; then
    run_gnome_extension_config Dash-to-Dock dash-to-dock@micxgx.gmail.com org.gnome.shell.extensions.dash-to-dock.gschema.xml
else
    echo "Running Setup"
fi


#
#    Setup Skripts
#

# Funktion zur Installation des Nvidia-Treibers
install_nvidia_driver() {
    read -p "Möchten Sie den Nvidia-Treiber über den Ubuntu-Autoinstaller installieren? (J/n): " choice
    choice=${choice:-'J'}

    if [ "$choice" = "J" ] || [ "$choice" = "j" ]; then
        echo "Nvidia-Treiber werden installiert"
        sudo ubuntu-drivers autoinstall
    else
        read -p "Möchten Sie den Nvidia-Treiber über apt installieren? (J/n): " choice
        choice=${choice:-'J'}
        if [ "$choice" = "J" ] || [ "$choice" = "j" ]; then
            echo "Nvidia-Treiber werden über apt installiert"
            sudo apt install nvidia-driver-535 nvidia-dkms-535
        else
            echo "Nvidia-Treiber wird nicht installiert."
        fi
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
