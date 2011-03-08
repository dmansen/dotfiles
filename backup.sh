#!/bin/sh

# run as root

date=`date "+%Y-%m-%dT%H:%M:%S"`

# Change these...
BACKUP_PATH=/            # the path you want to back up
BACKUP_DIR=/media/Backup # where to back this path up


LATEST=$BACKUP_DIR/latest
THIS_BACKUP=$BACKUP_DIR/back-$date

CUR_DIR=`pwd`
cd /home/derek/scripts

rsync -axP --link-dest="$LATEST" --exclude="/sys" --exclude="/proc" --exclude="/mnt" --exclude="/media" --exclude="/dev" --exclude="backup.errors" "$BACKUP_PATH" "$THIS_BACKUP" 2> backup.errors 
rm -f "$LATEST"
ln -s "$THIS_BACKUP" "$LATEST"

exit

cd "CUR_DIR"
