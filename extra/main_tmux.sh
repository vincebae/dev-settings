#!/bin/bash

session_name="sbbae"
tmux has-session -t $session_name
if [ "$?" -eq "0" ]; then
    tmux a -t $session_name
else
    tmux new-session -s $session_name -n "first" -d
    tmux new-window -n "second"
    tmux new-window -n "third"
    tmux select-window -t "first"
    tmux attach-session -t $session_name
fi
