#!/bin/bash

# Define session and command to run in tmux
SESSION_NAME="mcterm"
STOP_COMMAND="save-off"
SERVER_MESSAGE_SAVE_OFF="tell @a World saving being disabled to take backup"
date
tmux send-keys -t "$SESSION_NAME" "$SERVER_MESSAGE_SAVE_OFF" C-m
echo "Turning off auto-saving to prevent corruption"
tmux send-keys -t "$SESSION_NAME" "$STOP_COMMAND" C-m
sleep 10

#sleep for 120 seconds to allow server to shut down
#date
#echo "Sleep for 120 to allow server to shut down"
#sleep 120

date
echo "Starting backup"
# Define source directories to be backed up
SOURCE_DIRS=(
    "/home/opc/Server/MCwithFriends24"
    "/home/opc/Server/MCwithFriends24_nether"
    "/home/opc/Server/MCwithFriends24_the_end"
    "/home/opc/Server/server.properties"
    "/home/opc/Server/whitelist.json"
) 

# Define backup destination directory
BACKUP_DIR="/home/opc/backups" 

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Generate a unique backup filename with timestamp
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/backup_"$TIMESTAMP".tar.gz"

# Backup the source directory using tar
tar -zcvf "$BACKUP_FILE" "${SOURCE_DIRS[@]}"

date
echo "Backup created: $BACKUP_FILE"

# Remove backups older than 3 days
date
echo "Deleting backups older than 3 days"
find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +2 -delete


#sleep 10 before starting server
date
echo "Sleep 10 before turning auto saving back on"
sleep 10

#new command to start server in tmux
#START_COMMAND="/home/opc/Server/start.sh"
START_COMMAND="save-on"
SERVER_MESSAGE_SAVE_ON="tell @a World saving on backup complete"
tmux send-keys -t "$SESSION_NAME" "$START_COMMAND" C-m
tmux send-keys -t "$SESSION_NAME" "$SERVER_MESSAGE_SAVE_ON" C-m
date
#echo "Server started"
