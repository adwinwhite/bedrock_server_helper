#!/bin/bash

DIR="$(dirname "${BASH_SOURCE[0]}")"  # Get the directory name
DIR="$(realpath "${DIR}")"

# Check if server is already started
if screen -list | grep -q "Ziserver"; then
    echo "服务器已经在运行中了！ 输入 screen -r Ziserver 来打开它。"
    exit 1
fi

# Check if network interfaces are up
NetworkChecks=0
DefaultRoute=$(route -n | awk '$4 == "UG" {print $2}')
while [ -z "$DefaultRoute" ]; do
    echo "当前网络未链接，将在1秒后重试。";
    sleep 1;
    DefaultRoute=$(route -n | awk '$4 == "UG" {print $2}')
    NetworkChecks=$((NetworkChecks+1))
    if [ $NetworkChecks -gt 20 ]; then
        echo "等待网络超时 - 服务器将在无网络情况下启动..."
        break
    fi
done


# Change directory to server directory
cd "$DIR"



echo "正在启动Minecraft基岩版服务器，要查看状态请输入 screen -rd Ziserver"
echo "要让服务器在后台运行，请按 Ctrl+A 然后 Ctrl+D"
screen -dmS Ziserver /bin/bash -c "LD_LIBRARY_PATH=$DIR $DIR/bedrock_server"
