FROM farmcoolcow/rclone

RUN apk --update add py-pip && pip install --upgrade pip rotate-backups && rm -rf /var/cache/apk/* /tmp/*

COPY mount_rotate-backups.sh /mount_rotate-backups.sh

ENTRYPOINT ["/entrypoint_su-exec.sh", "/mount_rotate-backups.sh"]