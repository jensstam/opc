#!/bin/bash


#stop server
SESSION_NAME="mcterm"
COMMAND="stop"
date
echo "Stopping MC server"
echo tmux send-keys -t "$SESSION_NAME" "$COMMAND" C-m
sleep 5

#kill tmux session
date
echo "Killing tmux session"
echo tmux kill-session -t $SESSION_NAME
sleep 5

#check for java PID running and request to kill gracefully
date
echo "Checking for Java process running"
if 
    pgrep -x "java" > /dev/null 
then 
    echo "Requsting graceful kill for java PID"
    echo "kill $(pgrep -x "java")"
    sleep 60
else 
    echo "Java not running, no need to kill"
fi


# 
START_COMMAND="/home/opc/Spigot_Server/start.sh"
echo tmux send-keys -t "$SESSION_NAME" "$START_COMMAND" C-m


