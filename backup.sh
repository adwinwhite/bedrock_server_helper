#!/bin/bash

DIR="$(dirname "${BASH_SOURCE[0]}")"  # Get the directory name
DIR="$(realpath "${DIR}")"

# Change directory to server directory
cd "$DIR"

# Create backup
if [ -d "worlds" ]; then
    if [ ! -d "backups" ]; then
        mkdir backups
    fi
    echo "正在备份服务器至 backups"
    tar -pzvcf backups/$(date +%Y.%m.%d.%H.%M.%S).tar.gz worlds
fi
