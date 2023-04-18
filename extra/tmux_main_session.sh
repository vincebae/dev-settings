#!/bin/bash

session_name="sbbae"
tmux has-session -t $session_name
if [ "$?" -eq "0" ]; then
    tmux a -t $session_name
else
    tmux new-session -s $session_name -n "zero" -d \; split-window -h \; select-pane -t 0
    tmux new-window -n "first" \; split-window -h \; select-pane -t 0
    tmux new-window -n "second" \; split-window -h \; select-pane -t 0
    tmux new-window -n "third" \; split-window -h \; select-pane -t 0
    tmux select-window -t "zero"
    tmux attach-session -t $session_name
fi

