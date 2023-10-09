#!/bin/bash

session_name="sbbae"
split_window_with_resize="split-window -h -d -l 67%"
tmux has-session -t $session_name
if [ "$?" -eq "0" ]; then
    tmux a -t $session_name
else
    tmux new-session -s $session_name -n "first" -d \; ${split_window_with_resize}
    tmux new-window -n "second" \; ${split_window_with_resize}
    tmux new-window -n "third" \; ${split_window_with_resize}
    tmux select-window -t "first"
    tmux attach-session -t $session_name
fi
