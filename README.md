# docker-rclone-rotate-backups
simple image for rotating backups on a remote directory mounted with rclone

---

example usage:
```sh
#!/bin/sh

RCLONE_CONF=$(pwd)/rclone.conf
RCLONE_SRC=gdrive:/cismet/backups/
ROTATE_BACKUPS_PATH="*"
ROTATE_BACKUPS_OPTIONS="--dry-run --daily=10 --weekly=5 --monthly=13 --yearly=5"

# ===

DATA=$(pwd)/data
CONTAINER_NAME=backup_rotate_rclone
USER=$(whoami)

docker run -t --rm --name $CONTAINER_NAME \
    -e PUID=$(id -u $USER) \
    -e PGID=$(id -g $USER) \
    -v $RCLONE_CONF:/home/.rclone.conf \
    --device /dev/fuse \
    --privileged \
    cismet/rclone-rotate-backups \
        "$RCLONE_SRC" "$ROTATE_BACKUPS_PATH" "$ROTATE_BACKUPS_OPTIONS"
```
