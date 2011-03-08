#!/bin/sh

ANDROID_DIR=/media/FE4B-0FB2/Music
PLAYLIST_DIR=/home/derek/Music/Android
OUTPUT_DIR=/home/derek/scripts/output

CURRENT_DIR=`pwd`

# move to output directory
mkdir "$OUTPUT_DIR" 2> /dev/null
cd "$OUTPUT_DIR"

mkdir "$ANDROID_DIR" 2> /dev/null
rsync --size-only --progress -a --delete "$PLAYLIST_DIR"/ "$ANDROID_DIR" 2> sync.errors

cd "$CURRENT_DIR"
