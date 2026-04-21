#!/bin/bash

OFF_SITE_USER="bf"  # change to your user name on the other computer          #0
OFF_SITE_SH_DIR="~/sh"

SH_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

IP_INI_PATH="$SH_DIR/../io/ip_addr.ini"

USE_IP_INI=false

if [ "$1" == "-ip" ]; then
  USE_IP_INI=true
  shift
fi

if [ -z "$1" ]; then
  echo "Usage:"
  echo " $0 script.sh  args  (scan)"
  echo " $0 -ip script.sh  args  (config IP)"
  exit 1
fi

SH_NAME="$1"
shift




# Supply IP from an INI file:                                                 #1

if $USE_IP_INI; then

  if [ -f "$IP_INI_PATH" ]; then
    TARG_IP=$(head -n 1 "$IP_INI_PATH" | tr -d ' \t\r\n')
  fi

  if [[ "$TARG_IP" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Using config IP $TARG_IP"
  else
    echo "Got an erroneous IP:  $IP_INI_PATH"
    exit 1
  fi




# Scan IP address from your network:                                          #2

else
  echo "No IP flag -> scanning network"

  LOC_IP=$(hostname -I | awk '{print $1}')

  if [ -z "$LOC_IP" ]; then
    echo "No IP address found in the network"
    exit 1
  fi

  echo " My IP:  $LOC_IP"

  NET_PFIX=$(echo "$LOC_IP" | awk -F. '{print $1"."$2"."$3}')

  echo " Network:  $NET_PFIX.0/24"
  echo " Scanning SSH port (22)..."

# port 22 is safe from the outside world

  SCAN_FR_NMAP=$(nmap -p 22 --open ${NET_PFIX}.0/24)

  TARG_IP=$(echo "$SCAN_FR_NMAP" | awk '
  /Nmap scan report for/ {ip=$NF}
  /22\/tcp open/ {print ip; exit}
  ')

  if [ -z "$TARG_IP" ]; then
    echo "SSH computers not found in the network"
    exit 1
  fi

  echo "Found computer:  $TARG_IP"
fi




# Run script on remote computer:                                              #3

echo " Running script:  $SH_NAME"

ssh -o GSSAPIAuthentication=no \
    ${OFF_SITE_USER}@${TARG_IP} "bash ${OFF_SITE_SH_DIR}/${SH_NAME} $@"