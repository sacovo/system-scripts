#!/usr/bin/sh

NAME="name"

sudo -u postgres createuser --pwprompt $NAME
sudo -u postgres createdb --owner=$NAME $NAME
sudo -u postgres pg_restore -d $NAME --clean --if-exists "${NAME}_dump.sql" --no-owner --no-privileges --role=$NAME
