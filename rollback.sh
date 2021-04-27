#!/bin/bash
PRED=$(pwd)
SERVER_DIR="$(dirname "${BASH_SOURCE[0]}")"  # Get the directory name
SERVER_DIR="$(realpath "${SERVER_DIR}")"

cd $SERVER_DIR

# Check if server is already started
if screen -list | grep -q "Ziserver"; then
	echo "服务器在运行中！ 回滚前请停止服务器运行！"
	exit 1
fi

read -p "回滚会覆盖当前存档，如有需要请先手动备份。是否继续回滚? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

#echo "正在备份当前存档"
#tar -pzvcf backups/$(date +%Y.%m.%d.%H.%M.%S).tar.gz worlds
#echo "备份完毕"
trash -r worlds
echo "删除当前世界"

i=1
for BACKUP_FILE in backups/*.tar.gz; do
	echo "$i : $BACKUP_FILE"
	i=$((i+1))
done

read -p "输入你想回滚到的备份前的序号：" choice

i=1
for BACKUP_FILE in backups/*.tar.gz; do
	if test $choice -eq $i; then
		echo "你选择了$BACKUP_FILE"
		tar -xvzf $BACKUP_FILE 
		exit 0
	fi
	i=$((i+1))
done

if test -d worlds; then
	echo "回滚成功"
else
	echo "回滚失败"
fi


cd $PRED
