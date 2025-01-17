#!/bin/bash


#stop server
SESSION_NAME="mcterm"
SERVER_STOP_MESSAGE="tell @a Server will be shutting down and restarting in 60 seconds - this process normally takes approximately 2 mintues"
COMMAND="stop"

date
echo "Sending message to all players that server is restarting in 60 seconds"
tmux send-keys -t "$SESSION_NAME" "$SERVER_STOP_MESSAGE" C-m
sleep 60

date
echo "Stopping MC server and wait 90 seconds for shutdown"
tmux send-keys -t "$SESSION_NAME" "$COMMAND" C-m
sleep 90

#kill tmux session
#date
#echo "Killing tmux session"
#tmux kill-session -t $SESSION_NAME
#sleep 10

#check for java PID running and request to kill gracefully
date
echo "Checking for Java process running"
if pgrep -x "java" > /dev/null 
then
   date
   echo "Waiting additional 10 minutes to allow server to shut down naturally"
   sleep 600
   if pgrep -x "java" > /dev/null
   then
      date 
      echo "Server still running. Requsting graceful kill for java PID and wait 3 minutes for process to terminate"
      kill $(pgrep -x "java")
      sleep 180
      #kill java forcefully if it doesn't shut down gracefully
      if pgrep -x "java" > /dev/null
      then
         date
         echo "Java still running. Killing java forcefully and wait 60 seconds for process to terminate"
         kill -9 $(pgrep -x "java")
         sleep 60
      else echo "Java not running, no need to force kill"
      fi
   fi
else 
    echo "Java not running, no need to kill"
fi

#create new tmux session
#date
#echo "Creating new tmux session $SESSION_NAME"
#tmux new -s $SESSION_NAME
#sleep 10

# start server
date
echo "Starting server"
START_COMMAND="/home/opc/Spigot_Server/start.sh"
tmux send-keys -t "$SESSION_NAME" "$START_COMMAND" C-m


