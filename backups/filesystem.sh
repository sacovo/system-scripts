#!/usr/bin/sh

REPOSITORY=
REMOTE=
NAME=
TAG=

MOUNTPOINT=mnt/$NAME

mkdir -p $MOUNTPOINT

trap "umount $MOUNTPOINT" EXIT

sshfs $REMOTE $MOUNTPOINT -o ro

restic -r $REPOSITORY backup $MOUNTPOINT --tag $TAG
