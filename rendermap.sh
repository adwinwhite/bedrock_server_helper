#!/bin/bash

PRED="$(pwd)"
DIR="$(dirname "${BASH_SOURCE[0]}")"  # Get the directory name
DIR="$(realpath "${DIR}")"
PAPY_DOWNLOAD_URL="https://github.com/mjungnickel18/papyruscs/releases/download/v0.5.1/papyruscs-dotnetcore-0.5.1-linux64.zip"

PAPY_DIR="$(realpath "${DIR}/../papyruscs")"
if [ ! -d "PAPY_DIR" ]; then
  cd "${DIR}/.."
  wget "$PAPY_DOWNLOAD_URL" -o "papyruscs.zip"
  if [ ! -d "$PAPY_DIR" ]; then
    mkdir "$PAPY_DIR"
  fi
  unzip "papyruscs.zip" -d "$PAPY_DIR"
  chmod +x "$PAPY_DIR/PapyrusCs"
  cd "$PRED"
fi

# render the map
echo "正在更新网页地图..."
$PAPY_DIR/PapyrusCs --world "$DIR/worlds/Bedrock level/db" --dim 0 --output "/var/www/map" --htmlfile "index.html"
$PAPY_DIR/PapyrusCs --world "$DIR/worlds/Bedrock level/db" --dim 1 --output "/var/www/map" --htmlfile "index.html"
$PAPY_DIR/PapyrusCs --world "$DIR/worlds/Bedrock level/db" --dim 2 --output "/var/www/map" --htmlfile "index.html"
echo "网页地图更新完毕"
