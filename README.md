# System Scripts

Scripts and notes about how I do stuff with servers. Setup wireguard vpn, install docker and templates for docker compose with traefik as proxy, setup postgres, backups with restic, and more to come.

## Openstack

An external and internal network, so that only instances that need to be accessed acutally have a public ip adress. The external network needs a router and is connected to the external network, this gives
all instances egress connectivity to the interent. The internal network does not have a router. Security groups are used to only allow the necessary traffic to each instance over the internal network.

## Wireguard

One instance acts as a vpn, that allows management access to all the instances. Server and client setup is in the folder `wireguard`.

## Docker + Traefik

Traefik is the proxy server and forwards domains to different applications, that are usually installed with a docker-compose file. Examples and scripts are in the docker folder.

### Encrypted Environments

Environment files contain passwords, in order to not store them in plaintext on the filesystem they are encrypted, and decrypted to inject the keys into docker-compose starting the services. This is not
entirely secure, since the passwords are still in the environment of the docker instances, that use them.

## Tools
- restic: Backups
- rclone: Mounting filesystems
- postgres: Database
- Wireguard: vpn
- Docker
- Traefik
- Caddy
-
