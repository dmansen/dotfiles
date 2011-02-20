#!/bin/sh

sudo rsync -azv --exclude="/proc" --exclude="/mnt" --exclude="/media" --exclude="/dev" / /media/Backup
