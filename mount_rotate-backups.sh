#!/bin/sh

RCLONE_MOUNT_SRC=$1
shift
ROTATE_BACKUPS_PATH=$1
shift
ROTATE_BACKUPS_PARAMS=$*
RCLONE_MOUNT_DST=$ENTRYPOINT_HOME/mnt

rclone mount $RCLONE_MOUNT_SRC $RCLONE_MOUNT_DST || exit 1 &

mkdir $RCLONE_MOUNT_DST
while [ ! $(ls -ld $RCLONE_MOUNT_DST | awk '{print $5}') -eq 0 ]; do
    # echo "waiting for mount..."
    sleep 1;
done

rotate-backups $ROTATE_BACKUPS_PARAMS $RCLONE_MOUNT_DST/$ROTATE_BACKUPS_PATH