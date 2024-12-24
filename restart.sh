#!/bin/bash

SESSION_NAME="mcterm"
COMMAND="stop"
tmux send-keys -t "$SESSION_NAME" "$COMMAND" C-m
sleep 30

START_COMMAND="/home/opc/Spigot_Server/start.sh"
tmux send-keys -t "$SESSION_NAME" "$START_COMMAND" C-m


