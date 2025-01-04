#!/bin/bash

# Define session and command to run in tmux
SESSION_NAME="mcterm"
STOP_COMMAND="save-off"
date
echo "Turning off auto-saving to prevent corruption"
tmux send-keys -t "$SESSION_NAME" "$STOP_COMMAND" C-m
sleep 10

#sleep for 120 seconds to allow server to shut down
#date
#echo "Sleep for 120 to allow server to shut down"
#sleep 120

date
echo "Starting backup"
# Define source directory to backup
SOURCE_DIR="/home/opc/Spigot_Server" 

# Define backup destination directory
BACKUP_DIR="/home/opc/backups" 

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Generate a unique backup filename with timestamp
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/backup_"$TIMESTAMP".tar.gz"

# Backup the source directory using tar
tar -zcvf "$BACKUP_FILE" "$SOURCE_DIR"

date
echo "Backup created: $BACKUP_FILE"

# Remove backups older than 3 days
date
echo "Deleting backups older than 4 days"
find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +4 -delete


#sleep 10 before starting server
date
echo "Sleep 10 before turning auto saving back on"
sleep 10

#new command to start server in tmux
#START_COMMAND="/home/opc/Spigot_Server/start.sh"
START_COMMAND="save-on"
tmux send-keys -t "$SESSION_NAME" "$START_COMMAND" C-m
date
#echo "Server started"
