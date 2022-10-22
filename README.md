# backup-directadmin-rclone
Backup DirectAdmin files with Rclone

How to:
- Install rclone.
- Create DirectAdmin backup schedule.
- Use `./backup.sh` to start syncing files.

Configuration:

- `REMOTE_CONFIG`: remote name, normally `remote`.
- `BACKUP_DIR`: Where directadmin backup created, normally `/home/admin/admin_backups`.
- `BACKUP_DIR_DEST`: Directory where to store files in remote.

Cronjob:

You can combine with cronjob to make it backup by period:

Example:

```
EDITOR=nano crontab -e
0 4 * * * /root/backup.sh > /dev/null 2>&1
```
