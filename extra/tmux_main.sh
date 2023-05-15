#!/bin/bash

session_name="sbbae"
tmux has-session -t $session_name
if [ "$?" -eq "0" ]; then
    tmux a -t $session_name
else
    tmux new-session -s $session_name -n "first" -d \; split-window -h \; select-pane -t 1
    tmux new-window -n "second" \; split-window -h \; select-pane -t 1
    tmux new-window -n "third" \; split-window -h \; select-pane -t 1
    tmux select-window -t "first"
    tmux attach-session -t $session_name
fi
