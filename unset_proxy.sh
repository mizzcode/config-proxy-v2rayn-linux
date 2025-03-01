#!/bin/bash

# Menghapus proxy untuk terminal
echo "Menghapus proxy dari ~/.bashrc..."
sed -i '/export no_proxy=/d' ~/.bashrc
sed -i '/export https_proxy=/d' ~/.bashrc
sed -i '/export http_proxy=/d' ~/.bashrc
sed -i '/export all_proxy=/d' ~/.bashrc
source ~/.bashrc

# Menghapus konfigurasi proxy APT
echo "Removing APT proxy..."
sudo rm -f /etc/apt/apt.conf.d/01proxy

# Menghapus proxy di Snap
echo "Unsetting Snap proxy..."
sudo snap unset system proxy.http
sudo snap unset system proxy.https

# Restart Snap agar perubahan diterapkan
echo "Restarting Snap service..."
sudo systemctl restart snapd
snap refresh

# Menghapus proxy dari Git
echo "Removing Git proxy..."
git config --global --unset http.proxy
git config --global --unset https.proxy

echo "Proxy settings removed successfully!"
