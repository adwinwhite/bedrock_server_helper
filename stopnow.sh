#!/bin/bash

# Check if server is running
if ! screen -list | grep -q "Ziserver"; then
  echo "服务器当前未运行！"
  exit 1
fi

# Stop the server
screen -Rd Ziserver -X stuff "stop$(printf '\r')"

# Wait up to 20 seconds for server to close
StopChecks=0
while [ $StopChecks -lt 3 ]; do
  if ! screen -list | grep -q "Ziserver"; then
    break
  fi
  sleep 1;
  StopChecks=$((StopChecks+1))
done

# Force quit if server is still open
if screen -list | grep -q "Ziserver"; then
  echo "Minecraft服务器无法在3秒内停止，已执行手动关闭。"
  screen -S Ziserver -X quit
fi

echo "Minecraft服务器 Ziserver 已经停止了。"

