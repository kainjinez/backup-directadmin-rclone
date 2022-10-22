# BACKUP DIRECTADMIN
#!/bin/bash
REMOTE_CONFIG=
BACKUP_DIR_DEST=
BACKUP_DIR="/home/admin/admin_backups"
TIMESTAMP=$(date +"%F")
SECONDS=0
size=$(du -sh $BACKUP_DIR | awk '{ print $1}')
echo "Starting backup directory $BACKUP_DIR";
/usr/sbin/rclone move $BACKUP_DIR "$REMOTE_CONFIG:$BACKUP_DIR_DEST/$TIMESTAMP" >> /var/log/rclone.log 2>&1
# Clean up
rm -rf $BACKUP_DIR
/usr/sbin/rclone -q --min-age 6w delete "$REMOTE_CONFIG:$BACKUP_DIR_DEST" #Remove all backups older than 2 week
/usr/sbin/rclone -q --min-age 6w rmdirs "$REMOTE_CONFIG:$BACKUP_DIR_DEST" #Remove all empty folders older than 2 week
/usr/sbin/rclone cleanup "$REMOTE_CONFIG:" #Cleanup Trash
echo "Finished";
echo '';
duration=$SECONDS
echo "Total $size, $(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
