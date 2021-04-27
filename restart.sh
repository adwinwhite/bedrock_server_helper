#!/bin/bash
# James Chambers
# Minecraft Bedrock Server restart script

screen -Rd Ziserver -X stuff "say §c服务器即将重启，请合理安排您的活动...$(printf '\r')"


# Stop server
/bin/bash /root/Ziserver/stop.sh

# Render web map
/bin/bash /root/Ziserver/rendermap.sh

# Backup server
/bin/bash /root/Ziserver/backup.sh

# Update server
/bin/bash /root/Ziserver/update.sh

# Start server
/bin/bash /root/Ziserver/start.sh

