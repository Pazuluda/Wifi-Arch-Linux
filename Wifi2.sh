#!/bin/bash

while true; do
  clear
  echo "=== MENU REPARATION WIFI ARCHLINUX/KDE ==="
  echo
  echo "1) VERIFIER LA CARTE WIFI"
  echo "2) INSTALLER LES PAQUETS ESSENTIELS"
  echo "3) DESACTIVER IWD"
  echo "4) ACTIVER NETWORKMANAGER"
  echo "5) LISTER LES INTERFACES WIFI AVEC NMCLI"
  echo "6) FORCER L ACTIVATION DE L INTERFACE WIFI"
  echo "7) QUITTER"
  echo
  read -p "CHOISIS UNE OPTION (1-7) : " choix

  case $choix in
    1)
      echo
      echo ">>> Recherche des interfaces wifi..."
      ip link | grep -E 'wl|wifi'
      echo
      read -p "Appuie sur ENTREE pour continuer..."
      ;;
    2)
      echo
      echo ">>> Installation de linux-firmware, networkmanager, plasma-nm..."
      sudo pacman -Syu --noconfirm linux-firmware networkmanager plasma-nm
      echo
      read -p "Appuie sur ENTREE pour continuer..."
      ;;
    3)
      echo
      echo ">>> Desactivation du service iwd (si present)..."
      sudo systemctl disable --now iwd 2>/dev/null
      echo
      read -p "Appuie sur ENTREE pour continuer..."
      ;;
    4)
      echo
      echo ">>> Activation du service NetworkManager..."
      sudo systemctl enable --now NetworkManager
      echo
      read -p "Appuie sur ENTREE pour continuer..."
      ;;
    5)
      echo
      echo ">>> Interfaces wifi detectees par NetworkManager :"
      nmcli device status | grep wifi
      echo
      read -p "Appuie sur ENTREE pour continuer..."
      ;;
    6)
      echo
      echo ">>> Liste des interfaces wifi dispo :"
      ip link | grep -Eo '^[0-9]+: ([^:]+)' | grep -E 'wl|wifi'
      read -p "Tape le nom de l interface wifi a activer (ex : wlan0 ou wlp2s0) : " iface
      sudo ip link set $iface up
      echo "Interface $iface activee."
      read -p "Appuie sur ENTREE pour continuer..."
      ;;
    7)
      echo "A PLUS !"
      exit 0
      ;;
    *)
      echo "CHOIX INVALIDE !"
      read -p "Appuie sur ENTREE pour continuer..."
      ;;
  esac
done
