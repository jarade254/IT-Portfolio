#!/bin/bash
# Simple backup script
# Author: Jared Tonui
# Date: 2026-02-08

SOURCE="$HOME/Documents"
DEST="$HOME/Backup"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

mkdir -p "$DEST"
tar -czf "$DEST/backup_$DATE.tar.gz" "$SOURCE"

echo "Backup of $SOURCE completed at $DATE"
