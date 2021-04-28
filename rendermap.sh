#!/bin/bash

DIR="$(dirname "${BASH_SOURCE[0]}")"  # Get the directory name
DIR="$(realpath "${DIR}")"


PAPY_DIR="$(realpath "${DIR}/../papyruscs")"
WEB_DIR="$PAPY_DIR/www/map"
if [ ! -d "$PAPY_DIR" ]; then
  pushd "${DIR}/.."
  curl -s https://api.github.com/repos/mjungnickel18/papyruscs/releases/latest \
  | grep "browser_download_url" \
  | cut -d '"' -f 4 \
  | wget -qi - -o "papyruscs.zip"
  # wget "$PAPY_DOWNLOAD_URL" -o "papyruscs.zip"
  if [ ! -d "$PAPY_DIR" ]; then
    mkdir "$PAPY_DIR"
  fi
  unzip "papyruscs.zip" -d "$PAPY_DIR"
  chmod +x "$PAPY_DIR/PapyrusCs"
  popd
fi

# render the map
if [ ! -d "$WEB_DIR" ]; then
  mkdir -r "$WEB_DIR"
fi
echo "正在更新网页地图..."
$PAPY_DIR/PapyrusCs --world "$DIR/worlds/Bedrock level/db" --dim 0 --output "$WEB_DIR" --htmlfile "index.html"
$PAPY_DIR/PapyrusCs --world "$DIR/worlds/Bedrock level/db" --dim 1 --output "$WEB_DIR" --htmlfile "index.html"
$PAPY_DIR/PapyrusCs --world "$DIR/worlds/Bedrock level/db" --dim 2 --output "$WEB_DIR" --htmlfile "index.html"
echo "网页地图更新完毕"
