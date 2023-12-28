#!/bin/bash

session_name="quake"
tmux has-session -t $session_name
if [ "$?" -eq "0" ]; then
    tmux a -t $session_name
else
    tmux new -s $session_name -d \; split-window -h -d #\; split-window -h -d;
    tmux select-layout even-horizontal
    tmux a -t $session_name
fi
