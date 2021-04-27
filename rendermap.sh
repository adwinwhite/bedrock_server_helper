#!/bin/bash

DIR="$(dirname "${BASH_SOURCE[0]}")"  # Get the directory name
DIR="$(realpath "${DIR}")"

PAPY_DIR="$(realpath "${DIR}/../papyruscs")"

# render the map
echo "正在更新网页地图..."
$PAPY_DIR/PapyrusCs --world "$DIR/worlds/Bedrock level/db" --dim 0 --output "/var/www/map" --htmlfile "index.html"
$PAPY_DIR/PapyrusCs --world "$DIR/worlds/Bedrock level/db" --dim 1 --output "/var/www/map" --htmlfile "index.html"
$PAPY_DIR/PapyrusCs --world "$DIR/worlds/Bedrock level/db" --dim 2 --output "/var/www/map" --htmlfile "index.html"
echo "网页地图更新完毕"
