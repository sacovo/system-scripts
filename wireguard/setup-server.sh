#!/usr/bin/bash

PEER_KEY=$1
PEER_NETWORK=$2
PEER_IP=$3
SEVER_PORT=$4

sudo apt-get update && sudo apt-get upgrade
sudo apt-get install wireguard-tools

mkdir .wg && cd .wg
PRIVATE_KEY=$(wg genkey)
echo $PRIVATE_KEY > server.key
PUBLIC_KEY=$(wg pubkey < server.key)
echo $PUBLIC_KEY > server.pub

cat << EOF > /etc/wireguard/wg0.conf
[Interface]
PrivateKey = ${PRIVATE_KEY}
Address = ${PEER_NETWORK}
ListenPort = ${SEVER_PORT}

# IP forwarding
PreUp = sysctl -w net.ipv4.ip_forward=1
# IP masquerading
PreUp = iptables -t mangle -A PREROUTING -i wg0 -j MARK --set-mark 0x30
PreUp = iptables -t nat -A POSTROUTING ! -o wg0 -m mark --mark 0x30 -j MASQUERADE
PostDown = iptables -t mangle -D PREROUTING -i wg0 -j MARK --set-mark 0x30
PostDown = iptables -t nat -D POSTROUTING ! -o wg0 -m mark --mark 0x30 -j MASQUERADE

[Peer]
PublicKey = ${PEER_KEY}
AllowedIPs = ${PEER_IP}

EOF

sudo systemctl enable --now wg-quick@wg0
